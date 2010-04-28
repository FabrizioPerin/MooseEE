Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE' }
MooseModel >> allColumns [

	^self allWithType: MJFAMIXTablesColumn "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allDatabases [

	^self allWithType: MJFAMIXDataBase "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allEntityBeans [

	^self allWithType: MJFAMIXEntityBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allJEEBeans [

	^self allSessionBeans, self allEntityBeans, self allMessageDrivenBeans.
]

{ #category : #'*Moose-JEE' }
MooseModel >> allMaps [
	
	<navigation: 'All maps'>
	^self allWithType: MJFAMIXMapping
]

{ #category : #'*Moose-JEE' }
MooseModel >> allMessageDrivenBeans [

	^self allWithType: MJFAMIXMessageDrivenBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allSessionBeans [
	<navigation: 'All session beans'>

	^self allWithType: MJFAMIXSessionBean "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allTables [

	^self allWithType: MJFAMIXDBTable "asMetaDescription"
]

{ #category : #'*Moose-JEE' }
MooseModel >> allTransactionalMethods [
	<navigation: 'All methods involved in EJB transactions'>

	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*Moose-JEE' }
MooseModel >> annotateTheModelForJEEBrowser [

	<menuItem: 'Annotate the model with JEE informations' category: 'JEE Menu' >

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
	<menuItem: 'Build Relations Among DB And Methods' category: 'JEE Menu'>

	| tables entities counter |

	self isEJB30 
	ifTrue:[	
		entities := (self allAnnotationTypes select: [:each | each name = 'Table']) first annotatedEntities.
		tables := self allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among DB and Entities'
			at: Sensor cursorPoint
			from: counter
			to: (entities size * tables size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.
			
				tables do: [:table | 
					entities do: [:class |
						((class sourceText findString: ('@Table(name = "',table name,'"')) > 0)
								ifTrue:[ |mapping|
										mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
										class addMaps: mapping.
										table addMappedBy: mapping.
										self add: mapping.].
								counter := counter+1.
								bar value: counter.
								]]]]
	ifFalse:[
		entities := self allClasses select: [:class | class methods anySatisfy: #doesExecuteAQuery].
		tables := self allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among DB and Classes'
			at: Sensor cursorPoint
			from: counter
			to: (entities size * tables size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.
			
				tables do: [:table | 
					entities do: [:class |
						((class sourceText findString: table name) > 0)
								ifTrue:[ |mapping|
										mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
										class addMaps: mapping.
										table addMappedBy: mapping.
										self add: mapping.].
								counter := counter+1.
								bar value: counter.
								]]]]

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
MooseModel >> ejbVersion [
	<MSEProperty: #EJBVersion type: #Object>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeGet: #EJBVersion default: [nil]

]

{ #category : #'*Moose-JEE' }
MooseModel >> ejbVersion: aString [
	
	^self privateState attributeSet: #EJBVersion value: aString
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
	
	| fileSystem entries directoryEntries parser root counter |
	
	fileSystem := FSDiskFilesystem current referenceTo: aString.
	entries := FSCollectVisitor breadthFirst: fileSystem.
	
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
					parser := OPOpaxHandler on:stream.
					
					"parser startDocument."
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
					counter := counter + 1.
					bar value: counter.
				]].

]

{ #category : #'*Moose-JEE' }
MooseModel >> importEjbJarFromFolderGUI [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'JEE Menu'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importEjbJarFromFolder: folderName pathName.
]

{ #category : #'*Moose-JEE' }
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
		bean := MJFAMIXEntityBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class mooseID = (annotation annotatedEntity mooseID).] ) do: [:each | 
																			each parentEJBBean: bean.
																			bean implementationClass: each.].
		self add: bean ].

	messageDrivenBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	messageDrivenBeansAnnotations do: [:annotation | 
		| bean |
		bean := MJFAMIXMessageDrivenBean new name: annotation mooseName.
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
		bean := MJFAMIXSessionBean new name: annotation mooseName.
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
MooseModel >> isEJB21 [
	^self ejbVersion = 'EJB2.1'
]

{ #category : #'*Moose-JEE' }
MooseModel >> isEJB30 [
	^self ejbVersion = 'EJB3.0'
]

{ #category : #'*Moose-JEE' }
MooseModel >> populateWithRelationalElementsFrom: aBlackBoard [

	aBlackBoard databases do: [:each | self add: each createRelationalElement ].
	aBlackBoard tables  do: [:each | self add: each createRelationalElement ].
	aBlackBoard attributes do: [:each | self add: each createRelationalElement ].
	
	^self
]

{ #category : #'*Moose-JEE' }
MooseModel >> tryToFixFAMiXFileAnchorsFrom: aFolder [
	
	| allFileAnchors cursor |
	
	self flag: #TODOtest.
	
	self rootFolder: aFolder pathName.
	self name: aFolder localName.
	
	allFileAnchors := self allWithType: FAMIXFileAnchor.
	
	cursor := 1.
	UIManager default
		displayProgress: 'Fixing'
		at: Sensor cursorPoint
		from: cursor
		to: allFileAnchors size
		during: [ :bar | 
			allFileAnchors do: [:anchor | 
				| startingFrom |
				"Trying to readapt also the path separator in the case that you imported a mse file from another platform"
				OSProcess platformName = 'Win32'
					ifTrue: [
						[(anchor fileName indexOf: $/) = 0]
							whileFalse: [ 
								|newPath |
								newPath := anchor fileName.
								newPath at: (anchor fileName indexOf: $/) put: $\.
								anchor fileName: newPath.
								]]
					ifFalse: [
						[(anchor fileName indexOf: $\) = 0]
							whileFalse: [ 
								|newPath |
								newPath := anchor fileName.
								newPath at: (anchor fileName indexOf: $\) put: $/.
								anchor fileName: newPath.
								]].
			
				startingFrom := anchor fileName findString: self name.
				(startingFrom = 0) ifFalse: [
					startingFrom := anchor fileName findString: FileDirectory slash startingAt: startingFrom.
					anchor fileName: (anchor fileName copyFrom: startingFrom + 1 to: anchor fileName size)].
				cursor := cursor + 1.
				bar value: cursor.
				]].
	
]

{ #category : #'*Moose-JEE' }
MooseModel >> tryToFixFAMiXFileAnchorsGUI [
	<menuItem: 'Try to fix links with files' category: 'JEE Menu'>

	| folder |
	
	folder := UITheme builder chooseDirectory: 'Choose the root folder for the sources of ', self name.
	"folder := FileDirectory on: aPathString"
	folder ifNotNil: [ self tryToFixFAMiXFileAnchorsFrom: folder].
]
