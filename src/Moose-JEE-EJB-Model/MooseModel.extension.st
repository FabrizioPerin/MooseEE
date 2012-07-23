Extension { #name : #MooseModel }

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> allEntityBeans [
	<navigation: 'All Entity Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXEntityBean ofGroupClass: MJFAMIXEntityBeanGroup.
	group description: 'All Entity Beans'.
	^group
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> allJEEBeans [

	^self allSessionBeans, self allEntityBeans, self allMessageDrivenBeans.
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> allMessageDrivenBeans [
	<navigation: 'All Message Driven Beans'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXMessageDrivenBean ofGroupClass: MJFAMIXMessageDrivenBeanGroup.
	group description: 'All Message Driven Beans'.
	^group
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> allSessionBeans [
	<navigation: 'All Session Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXSessionBean ofGroupClass: MJFAMIXSessionBeanGroup.
	group description: 'All Session Beans'.
	^group
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> allTransactionalMethods [
	
	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> annotateTheModelForJEEBrowser [

	<menuItem: 'Annotate the model with JEE informations' category: 'JEAs Utilities' >

	self createAnnotationForTransactionScope.
	self createAnnotationForUnsafeQuery.
	
	^self
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> browseCodeWithAnnotationsForJEA [
	<menuItem: 'Code Browser For JEA' category: 'JEAs Utilities'>
	MooseBrowsers new codeBrowserForJEA openOn: self	
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> createAnnotationForTransactionScope [

	"Creation of the annotation types"
	| transactionScopeType interestingClasses allInterestingMethods allNamespaces transactionScopeTypeGroup |
	transactionScopeTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #transactionScope ].
	( transactionScopeTypeGroup isNil or: [ transactionScopeTypeGroup isEmpty ] )
			ifTrue: [ transactionScopeType := FAMIXAnnotationType new name: #transactionScope]
			ifFalse: [transactionScopeType := transactionScopeTypeGroup first].
	self silentlyAdd: transactionScopeType.

	
	"Creation of the annotation istances for method and classes for transactionScope"
	interestingClasses := ( self allClasses select: [ :class | class isStub not and:[ (class methods select: #isPartOfATransaction) notEmpty ] ] ).
	allInterestingMethods := interestingClasses allMethods select: #isPartOfATransaction.
	allNamespaces := interestingClasses collect: [:class | class container ].
	
	allNamespaces do: [:namespace | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: namespace.
							self silentlyAdd: instance.
							 ].
	
	interestingClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: class.
							self silentlyAdd: instance.
							 ].		

	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: method.
							self silentlyAdd: instance.
							 ].	

	^self
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> createAnnotationForUnsafeQuery [

	| unsafeQueryType allInterestingMethods interestingClasses interestingClassesWithoutLonelyClasses allNamespaces unsafeQueryTypeGroup |

	"Creation of the annotation types"
	unsafeQueryTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #unsafeQuery ].
	( unsafeQueryTypeGroup isNil or: [ unsafeQueryTypeGroup isEmpty ] )
			ifTrue: [ unsafeQueryType := FAMIXAnnotationType new name: #unsafeQuery]
			ifFalse: [unsafeQueryType := unsafeQueryTypeGroup first].
	self silentlyAdd: unsafeQueryType.

	
	"Creation of annotation instances on methods and classes for Unsafe Query "
	allInterestingMethods := ( FAMIXMethodGroup withAll: ( ( self allMethods ) select: #doesExecuteAQuery ) ) deepCalleeMethodsWithoutTransactionPath.
	interestingClasses := FAMIXClassGroup new addAll: ( self allClasses select: [ :eachClass | 
															(eachClass methods intersection: allInterestingMethods) notEmpty ] ).
	interestingClassesWithoutLonelyClasses := interestingClasses 
												reject: [ :class | ( class invokingClasses intersection: interestingClasses ) isEmpty 
																	and: [ ( class invokedClasses intersection: interestingClasses ) isEmpty ] ].
	allNamespaces := interestingClassesWithoutLonelyClasses collect: [:class | class container ].
	
	allNamespaces do: [:namespace | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: namespace.
							self silentlyAdd: instance.
							 ].	

	interestingClassesWithoutLonelyClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: class.
							self silentlyAdd: instance.
							 ].		
	
	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: method.
							self silentlyAdd: instance.
							 ].	

	^self
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> ejbVersion [
	^self privateState attributeAt: #ejbVersion ifAbsent: [nil]

]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> ejbVersion: aSymbol [
	^self privateState attributeAt: #ejbVersion put: aSymbol
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> importEjbJarFromFolder: aString [
	
	| fileSystem entries directoryEntries parser factory doc root counter |
	
	fileSystem := FileSystem onDisk referenceTo: aString.
	entries := CollectVisitor breadthFirst: fileSystem.
	
	directoryEntries := entries select: [:entry| '.*ejb-jar.xml$' asRegex matches: entry reference name ].

	counter := 1.			
	UIManager default
		displayProgress: 'Importing From ejb-jar files'
		at: Sensor cursorPoint
		from: 1 
		to: directoryEntries size
		during: [ :bar | 
			bar  value: counter.
			
			directoryEntries do: [:entry |
				
					 | stream |
					
					stream := StandardFileStream readOnlyFileNamed: (entry reference name).
					parser := XMLDOMParser on: stream.
					factory := XMLPluggableElementFactory new
									elementClass: MJEJBeanElement;
									handleElement: 'entity' withClass: MJEntityElement;
									handleElement: 'message-driven' withClass: MJMessageDrivenElement;
									handleElement: 'session' withClass: MJSessionElement;
									handleElement: 'container-transaction' withClass: MJContainerTransactionElement.
					parser nodeFactory: factory.
					doc := parser parseDocument.
					root := doc root.
							
					(root allElements select: [:eachElement | eachElement class = MJSessionElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJEntityElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJMessageDrivenElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJContainerTransactionElement]) do: [:eachElement |
							eachElement populate: self].
					counter := counter + 1.
					bar value: counter.
				]].

]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> importEjbJarFromFolderGUI [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'JEAs Importers'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importEjbJarFromFolder: folderName pathName.
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> initAndOpenJEEFromFolder: srcFolderString [
	
	| applicationName |
	
	self rootFolder: srcFolderString.
	applicationName := srcFolderString sliceFrom: ((srcFolderString findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1).
	self name: applicationName.

	self importFromMSEStream: (StandardFileStream readOnlyFileNamed: (FileDirectory default fullName,
											FileDirectory slash,
											'inFusion',
											FileDirectory slash,
											'tools',
											FileDirectory slash,
											'inFusion',
											FileDirectory slash,
											'project.mse')).

	"for moose app"
	"self importFromMSEStream: (StandardFileStream readOnlyFileNamed: (FileDirectory default fullName,
											FileDirectory slash,
											'..',
											FileDirectory slash,
											'..',								
											FileDirectory slash,
											'inFusion',
											FileDirectory slash,
											'tools',
											FileDirectory slash,
											'inFusion',
											FileDirectory slash,
											'project.mse'))."


self importEjbJarFromFolder: srcFolderString.
self annotateTheModelForJEEBrowser.

self install.

self allModelClasses viewTransactionFlow.
self allModelClasses viewUnsafeQueries.
self browseCodeWithAnnotationsForJEA.

MoosePanel open.

]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> instanciateJBeansFromAnnotations [
	<menuItem: 'Import beans from annotations' category: 'JEAs Importers'>
	
	| entityBeansAnnotations messageDrivenBeansAnnotations sessionBeansAnnotations transactionAttributes counter |
	
	entityBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Entity'].
	messageDrivenBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	sessionBeansAnnotations := self allAnnotationInstances entities select: [:each | 
																				each annotationType name = 'Stateless' or: [
																					each annotationType name = 'Stateful'] ].
	transactionAttributes := self allAnnotationTypes select: [:each | each name = 'TransactionAttribute'].
	
	counter := 1.
																					
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: (entityBeansAnnotations size + messageDrivenBeansAnnotations size + sessionBeansAnnotations size + transactionAttributes size)
		during: [ :bar | 
	
			bar value: counter.
	
			bar value: 'Importing Entity Beans'.
			entityBeansAnnotations do: [:annotation | 
				| bean |
				bean := MJFAMIXEntityBean new name: annotation mooseName.
				( self allClasses select: [:class |
					class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																					each parentEJBBean: bean.
																					bean implementationClass: each.].
				counter := counter +1.
				bar value: counter.
				self silentlyAdd: bean ].

			bar value: 'Importing Message Driven Beans'.
			messageDrivenBeansAnnotations do: [:annotation | 
				| bean |
				bean := MJFAMIXMessageDrivenBean new name: annotation mooseName.
				( self allClasses select: [:class |
					class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																					each parentEJBBean: bean.
																					bean implementationClass: each.].
				counter := counter +1.
				bar value: counter.
				self silentlyAdd: bean ].
	
			bar value: 'Importing Session Beans'.
			sessionBeansAnnotations do: [:annotation | 
				| bean |
				bean := MJFAMIXSessionBean new name: annotation mooseName.
				bean sessionType: annotation annotationType name.
				( self allClasses select: [:class |
					class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																					each parentEJBBean: bean.
																					bean implementationClass: each.].
				counter := counter +1.
				bar value: counter.
				self silentlyAdd: bean].
	
			bar value: 'Importing Transaction Attributes'.
			transactionAttributes do: [:annotation |
				"maintain the order: classes have to be analized before methods because annotations at method level they override the class one"
				| classes methods |

				classes := annotation annotatedEntities select: [:each | each isKindOf: FAMIXClass].
				methods := annotation annotatedEntities select: [:each | each isKindOf: FAMIXMethod].
	
				classes do: [:class | class methods do: [:method | method ejbTransactionType: 'REQUIRES_NEW' ] ].
				methods do: [:method | method ejbTransactionType: 'REQUIRES_NEW' ].	
					
				counter := counter +1.
				bar value: counter.	
			]].
	
	^self
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> isEJB21 [
	^self ejbVersion = #EJB21
]

{ #category : #'*moose-jee-ejb-model' }
MooseModel >> isEJB30 [
	^self ejbVersion = #EJB30
]
