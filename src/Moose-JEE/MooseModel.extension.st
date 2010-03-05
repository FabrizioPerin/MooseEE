Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE' }
MooseModel >> allColumns [

	^self allWithType: FAMIXTablesColumn "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allDatabases [

	^self allWithType: FAMIXDataBase "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allEntityBeans [

	^self allWithType: FAMIXEntityBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allJEEBeans [

	^self allSessionBeans, self allEntityBeans, self allMessageDrivenBeans.
]

{ #category : #'*Moose-JEE' }
MooseModel >> allMessageDrivenBeans [

	^self allWithType: FAMIXMessageDrivenBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allSessionBeans [
	<navigation: 'All session beans'>

	^self allWithType: FAMIXSessionBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allTables [

	^self allWithType: FAMIXDBTable "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allTransactionalMethods [
	<navigation: 'All methods involved in EJB transactions'>

	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*Moose-JEE' }
MooseModel >> annotateTheModelForJEEBrowser [

	<menuItem: 'Annotate the model with JEE informations' category: 'JEE Menu'>

	self createAnnotationForTransactionScope.
	self createAnnotationForUnsafeQuery.
	
	^self
]

{ #category : #'*Moose-JEE' }
MooseModel >> bookmarkNamed: aSymbol ifAbsent: aBlock [

	self flag: #toRemove.
	^self bookmarks detect: [:each | each mooseName = aSymbol ] ifNone: aBlock
]

{ #category : #'*Moose-JEE' }
MooseModel >> browseCodeWithAnnotationsForJEA [
	<menuItem: 'Code Browser For JEA' category: 'JEE Menu'>
	MooseBrowsers new codeBrowserForJEA openOn: self	
]

{ #category : #'*Moose-JEE' }
MooseModel >> buildRelationsAmongDBElementsAndMethods [

| tables entities out |
out := OrderedCollection new.
entities := (MooseModel root first allAnnotationTypes select: [:each | each name = 'Table']) first annotatedEntities.

tables := MooseModel root first allTables.
tables do: [:table | out add: (entities select: [:each | table nameAsRegex matches: each sourceText withoutLineEndings  ]) ].
out inspect.

]

{ #category : #'*Moose-JEE' }
MooseModel >> createAnnotationForTransactionScope [

	"Creation of the annotation types"
	| transactionScopeType interestingClasses allInterestingMethods allNamespaces transactionScopeTypeGroup |
	transactionScopeTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #transactionScope ].
	( transactionScopeTypeGroup isNil or: [ transactionScopeTypeGroup isEmpty ] )
			ifTrue: [ transactionScopeType := FAMIXAnnotationType new name: #transactionScope]
			ifFalse: [transactionScopeType := transactionScopeTypeGroup first].
	self add: transactionScopeType.

	
	"Creation of the annotation istances for method and classes for transactionScope"
	interestingClasses := ( self allClasses select: [ :class | class isStub not and:[ (class methods select: #isPartOfATransaction) notEmpty ] ] ).
	allInterestingMethods := interestingClasses allMethods select: #isPartOfATransaction.
	allNamespaces := interestingClasses collect: [:class | class container ].
	
	allNamespaces do: [:namespace | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: namespace.
							self add: instance.
							 ].
	
	interestingClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: class.
							self add: instance.
							 ].		

	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: method.
							self add: instance.
							 ].	

	^self
]

{ #category : #'*Moose-JEE' }
MooseModel >> createAnnotationForUnsafeQuery [

	| unsafeQueryType allInterestingMethods interestingClasses interestingClassesWithoutLonelyClasses allNamespaces unsafeQueryTypeGroup |

	"Creation of the annotation types"
	unsafeQueryTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #unsafeQuery ].
	( unsafeQueryTypeGroup isNil or: [ unsafeQueryTypeGroup isEmpty ] )
			ifTrue: [ unsafeQueryType := FAMIXAnnotationType new name: #unsafeQuery]
			ifFalse: [unsafeQueryType := unsafeQueryTypeGroup first].
	self add: unsafeQueryType.

	
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
							self add: instance.
							 ].	

	interestingClassesWithoutLonelyClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: class.
							self add: instance.
							 ].		
	
	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: method.
							self add: instance.
							 ].	

	^self
]

{ #category : #'*Moose-JEE' }
MooseModel >> importDBFromSQLFile: aFileStream [
	
	| parser result |
	
	parser := PGSQLParser new stream: aFileStream.
	result := parser run.
	
	self populateWithRelationalElementsFrom: parser blackBoard.
	
	"| tables entities out |
out := OrderedCollection new.
entities := (MooseModel root first allAnnotationTypes select: [:each | each name = 'Table']) first annotatedEntities.

tables := MooseModel root first allTables.
tables do: [:table | out add: (entities select: [:each | table nameAsRegex matches: each sourceText withoutLineEndings  ]) ].
out inspect."
		
	^self

]

{ #category : #'*Moose-JEE' }
MooseModel >> importDBFromSQLFileGUI [
	<menuItem: 'Import database from SQL file' category: 'JEE Menu'>
	
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').
		
	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[self importDBFromSQLFile: file readStream].
]

{ #category : #'*Moose-JEE' }
MooseModel >> importEjbJarFromFolder: aString [
	
	| fileSystem entries directoryEntries parser root |
	
	fileSystem := FSDiskFilesystem current referenceTo: aString.
	entries := FSCollectVisitor breadthFirst: fileSystem.
	
	directoryEntries := entries select: [:entry| '.*ejb-jar.xml$' asRegex matches: entry reference name ].
	
	directoryEntries do: [:entry | 
					| file |
					file := FileStream readOnlyFileNamed: (entry reference name).
					parser := OPOpaxHandler on: file readStream. 
				
					parser startDocument.
					parser parseDocument.
					root := parser stack first.
							
					(root allChildren select: [:eachElement | eachElement class = SessionElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = EntityElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = MessageDrivenElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = ContainerTransactionElement]) do: [:eachElement |
							eachElement populate: self].
				].

]

{ #category : #'*Moose-JEE' }
MooseModel >> importEjbJarFromFolderGUI [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'JEE Menu'>

	| folderName parser root |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].
	
	self importEjbJarFromFolder: folderName pathName.
]

{ #category : #'*Moose-JEE' }
MooseModel >> initAndOpenJEEFromFolder: srcFolderString withName: applicationNameString [ 
	
	self rootFolder: srcFolderString.
	self name: applicationNameString.

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

self allModelClasses viewTransactionFlow3.
self allModelClasses viewUnsafeQueries.
self browseCodeWithAnnotationsForJEA.

MoosePanel open.

]

{ #category : #'*Moose-JEE' }
MooseModel >> instanciateJBeansFromAnnotations [
	<menuItem: 'Import beans from annotations' category: 'JEE Menu'>
	
	| entityBeansAnnotations messageDrivenBeansAnnotations sessionBeansAnnotations transactionAttributes |
	
	entityBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Entity'].
	entityBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXEntityBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																			each parentEJBBean: bean.
																			bean implementationClass: each.].
		self add: bean ].

	messageDrivenBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	messageDrivenBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXMessageDrivenBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																			each parentEJBBean: bean.
																			bean implementationClass: each.].
		self add: bean ].
	
	sessionBeansAnnotations := self allAnnotationInstances entities select: [:each | 
																				each annotationType name = 'Stateless' or: [
																					each annotationType name = 'Stateful'] ].
	sessionBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXSessionBean new name: annotation mooseName.
		bean sessionType: annotation annotationType name.
		( self allClasses select: [:class |
			class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																			each parentEJBBean: bean.
																			bean implementationClass: each.].
		self add: bean 
	].
	
	transactionAttributes := self allAnnotationTypes select: [:each | each name = 'TransactionAttribute'].
	transactionAttributes do: [:annotation |
		"maintain the order: classes have to be analized before methods because annotations at method level they override the class one"
		| classes methods |

		classes := annotation annotatedEntities select: [:each | each isKindOf: FAMIXClass].
		methods := annotation annotatedEntities select: [:each | each isKindOf: FAMIXMethod].
	
		classes do: [:class | class methods do: [:method | method ejbTransactionType: 'REQUIRES_NEW' ] ].
		methods do: [:method | method ejbTransactionType: 'REQUIRES_NEW' ].		
	].
	
	^self
]

{ #category : #'*Moose-JEE' }
MooseModel >> populateWithRelationalElementsFrom: aBlackBoard [

	aBlackBoard databases do: [:each | self add: each createRelationalElement ].
	aBlackBoard tables  do: [:each | self add: each createRelationalElement ].
	aBlackBoard attributes do: [:each | self add: each createRelationalElement ].
	
	^self
]
