Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> add: anElement [ 
	 
	super add: anElement. 
	anElement privateSetMooseModel: self.
	"self announcer announce: (MooseEntityAdded new entity: anElement)."
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allColumns [
	<navigation: 'All Table Columns'>
	
	| group |
	
	
	group := self allWithType: MJFAMIXColumn ofGroupClass: MJFAMIXColumnGroup.
	group description: 'All Table Columns'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allDBAccesses [
	<navigation: 'All DB accessses'>

	| group |
	
	group :=  self allWithType: MJFAMIXDBAccess.
	group description: 'All DB accessses'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allDataLayer [
	"it should always be one"
	^self allWithType: MJFAMIXDataLayer
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allDatabases [

	^self allWithType: MJFAMIXDataBase "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allDerivedDependencies [

	^self allWithType: MJFAMIXDerivedDependency "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allEntityBeans [
	<navigation: 'All Entity Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXEntityBean ofGroupClass: MJFAMIXEntityBeanGroup.
	group description: 'All Entity Beans'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allFKAssociations [
	<navigation: 'All FK associations'>

	| group |
	
	group :=  self allWithType: MJFAMIXFKAssociation ofGroupClass: MJFAMIXFKAssociationGroup.
	group description: 'All FK associations'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allJEEBeans [

	^self allSessionBeans, self allEntityBeans, self allMessageDrivenBeans.
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allJSPInvocations [
	<navigation: 'All JSPage Invocations'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPInvocation.
	group description: 'JSPage Invocations'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allJSPages [
	<navigation: 'All JSPages'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPPage.
	group description: 'JSPages'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allLayers [
	<navigation: 'All Maps'>

	| group |

	group := MJFAMIXLayerGroup new addAll: self allPresentationLayer.
	group addAll: self allLogicLayer.
	group addAll: self allDataLayer.
	group addAll: self allServiceLayer.
	
	group description: 'All Standard Layers'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allLogicLayer [

	^self allWithType: MJFAMIXLogicLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allMaps [
	<navigation: 'All Maps'>

	| group |
	
	group :=  self allWithType: MJFAMIXMapping ofGroupClass: MJFAMIXMappingGroup.
	group description: 'All Maps'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allMessageDrivenBeans [
	<navigation: 'All Message Driven Beans'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXMessageDrivenBean ofGroupClass: MJFAMIXMessageDrivenBeanGroup.
	group description: 'All Message Driven Beans'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allPresentationLayer [

	^self allWithType: MJFAMIXPresentationLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allServiceLayer [

	^self allWithType: MJFAMIXServiceLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allSessionBeans [
	<navigation: 'All Session Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXSessionBean ofGroupClass: MJFAMIXSessionBeanGroup.
	group description: 'All Session Beans'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allTables [
	<navigation: 'All Data Base Tables'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXTable ofGroupClass: MJFAMIXTableGroup.
	group description: 'All Data Base Tables'.
	^group
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allTransactionalMethods [
	
	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> annotateTheModelForJEEBrowser [

	<menuItem: 'Annotate the model with JEE informations' category: 'JEAs Utilities' >

	self createAnnotationForTransactionScope.
	self createAnnotationForUnsafeQuery.
	
	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> browseCodeWithAnnotationsForJEA [
	<menuItem: 'Code Browser For JEA' category: 'JEAs Utilities'>
	MooseBrowsers new codeBrowserForJEA openOn: self	
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> buildMappingBetweenSoftwareEntityAndRelationalElements [
	<menuItem: 'Build mapping between relational entity and source code entity' category: 'JEAs Importers'>
	
	|  question strategy |

	strategy := UITheme builder chooseDropList: 'Choose the method to use for the mapping ' list: ((MJMappingStrategy methods reject: [:each | each category = #initialization ]) collect: [:method | method selector asString]).
	
	strategy isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			(MJMappingStrategy on: self) perform: strategy asSymbol ].
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpAllMaps [
	
	self withoutAnnounceRemoveAll: (self allWithType: MJFAMIXMapping).
	self allClasses do: [:class | class removePointersToMaps ].
	self allTables do: [:table | table removePointersToMaps ]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpAllMapsGUI [
	<menuItem: 'Clean up all maps' category: 'JEAs Utilities'>
	
	|  question strategy |

	question := UITheme builder questionWithoutCancel: 'Do you want to clean up previously created maps?'.
	question ifTrue: [self cleanUpAllMaps].
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpDuplicatedDeriveDependencies [
	<menuItem: 'Clean up duplicated derived dependencies' category: 'JEAs Utilities'>
	
	| dd toRemove|
	
	dd := self allDerivedDependencies.
	toRemove := OrderedCollection new.
	(1 to: dd size) do: [:firstDDIndex |
		((firstDDIndex + 1) to: dd size) do: [:secondDDIndex |
			((dd at: firstDDIndex) source = (dd at: secondDDIndex) source) ifTrue: [
				((dd at: firstDDIndex) target = (dd at: secondDDIndex) target) ifTrue: [
					((dd at: firstDDIndex) isDirected = (dd at: secondDDIndex) isDirected) ifTrue: [
						((dd at: firstDDIndex) rationale = (dd at: secondDDIndex) rationale) ifTrue: [
							toRemove add: (dd at: secondDDIndex) ]]]]]].
	
	self withoutAnnounceRemoveAll: toRemove asSet.  
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpDuplicatedMaps [
	<menuItem: 'Clean up duplicated maps' category: 'JEAs Utilities'>
	
	| maps toRemove |
	
	maps := self allMaps.
	toRemove := OrderedCollection new.
	
	(1 to: maps size) do: [:firstMapIndex |
		((firstMapIndex + 1) to: maps size) do: [:secondMapIndex |
			((maps at: firstMapIndex) mapSource = (maps at: secondMapIndex) mapSource) ifTrue: [
				((maps at: firstMapIndex) mapTarget = (maps at: secondMapIndex) mapTarget) ifTrue: [
					toRemove add: (maps at: secondMapIndex) ]]]].
	
	self withoutAnnounceRemoveAll: toRemove asSet.  
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpLayers [
	<menuItem: 'Clean up all layers' category: 'JEAs Utilities'>
	
	MJFAMIXLayer allSubclasses do: [:each | self withoutAnnounceRemoveAll: (self allWithType: each)].
	

]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> createAnnotationForTransactionScope [

	"Creation of the annotation types"
	| transactionScopeType interestingClasses allInterestingMethods allNamespaces transactionScopeTypeGroup |
	transactionScopeTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #transactionScope ].
	( transactionScopeTypeGroup isNil or: [ transactionScopeTypeGroup isEmpty ] )
			ifTrue: [ transactionScopeType := FAMIXAnnotationType new name: #transactionScope]
			ifFalse: [transactionScopeType := transactionScopeTypeGroup first].
	self withoutAnnounceAdd: transactionScopeType.

	
	"Creation of the annotation istances for method and classes for transactionScope"
	interestingClasses := ( self allClasses select: [ :class | class isStub not and:[ (class methods select: #isPartOfATransaction) notEmpty ] ] ).
	allInterestingMethods := interestingClasses allMethods select: #isPartOfATransaction.
	allNamespaces := interestingClasses collect: [:class | class container ].
	
	allNamespaces do: [:namespace | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: namespace.
							self withoutAnnounceAdd: instance.
							 ].
	
	interestingClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: class.
							self withoutAnnounceAdd: instance.
							 ].		

	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: transactionScopeType.
							instance annotatedEntity: method.
							self withoutAnnounceAdd: instance.
							 ].	

	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> createAnnotationForUnsafeQuery [

	| unsafeQueryType allInterestingMethods interestingClasses interestingClassesWithoutLonelyClasses allNamespaces unsafeQueryTypeGroup |

	"Creation of the annotation types"
	unsafeQueryTypeGroup := self allAnnotationTypes select: [:annotationType | annotationType name = #unsafeQuery ].
	( unsafeQueryTypeGroup isNil or: [ unsafeQueryTypeGroup isEmpty ] )
			ifTrue: [ unsafeQueryType := FAMIXAnnotationType new name: #unsafeQuery]
			ifFalse: [unsafeQueryType := unsafeQueryTypeGroup first].
	self withoutAnnounceAdd: unsafeQueryType.

	
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
							self withoutAnnounceAdd: instance.
							 ].	

	interestingClassesWithoutLonelyClasses do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: class.
							self withoutAnnounceAdd: instance.
							 ].		
	
	allInterestingMethods do: [:method | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: unsafeQueryType.
							instance annotatedEntity: method.
							self withoutAnnounceAdd: instance.
							 ].	

	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> ejbVersion [
	^self privateState attributeAt: #ejbVersion ifAbsent: [nil]

]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> ejbVersion: aSymbol [
	^self privateState attributeAt: #ejbVersion put: aSymbol
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> fixFileAnchorsFrom: aFolder [ 
	| index startingPoint javaFiles |

	self rootFolder: aFolder pathName.
	self name: aFolder localName.
	index := 1.
	
	javaFiles := OrderedCollection new.
	startingPoint := aFolder entries asOrderedCollection.
	
	startingPoint do: [:each | 
		each isDirectory 
			ifFalse: [('.*\.java$' asRegex matches: each name) ifTrue: [javaFiles add: each]]
			ifTrue: [startingPoint addAll: each asFileDirectory entries]].
	
	UIManager default
		displayProgress: 'Fixing'
		at: Sensor cursorPoint
		from: index
		to: self allClasses size * javaFiles size
		during: [:bar | 
			bar value: index.

			self allClasses
				do: [:class | 
					javaFiles do: [:file |
						(class name , '.java' = file name) ifTrue: [
							"| fileStream |
							fileStream := CrLfFileStream new open: file fullName forWrite: false."
							class sourceAnchor fileName: (file fullName copyFrom: (self rootFolder size + 1) to: file fullName size)].
						index := index + 1.
						bar value: index]]]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> fixFileAnchorsFromGUI [
	| aFolder |
	<menuItem: 'Try to fix file anchors' category: 'JEAs Utilities'>
	aFolder := UITheme builder chooseDirectory: 'Choose the root folder for ' , self name.
	aFolder isNil
		ifTrue: [DialogWindow new alert: 'Folder not found.']
		ifFalse: [self fixFileAnchorsFrom: aFolder]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importDBFromSQLFile: aFileStream [
	| parser result ejbVer |

	self deprecated: 'Use importDBFromSQLFileUsingAST: instead ' on: '18 March 2011' in: nil.   

	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
			PPParserResource reset.
			parser := PPParserResource current parserAt: PetitSQLiteParser.
	
			bar value: 2.
			bar value: 'Parsing SQL file'.
			result := parser parse: ([ aFileStream contentsOfEntireFile ]
										ensure: [ aFileStream close ]).
			bar value: 3.
			bar value: 'Populate the model'.
			self populateWithRelationalElementsFrom: parser blackBoard.
			
			self ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					self ejbVersion: ejbVer.].

			bar value: 4.
			bar value: 'Building relations'.
			
			"self buildRelationsAmongDBTablesAndClasses.			
			self buildRelationsAmongTableColumnsAndMethods."
			
			bar value: 5].
	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importDBFromSQLFileUsingAST: aFileStream [
	
	| parser result ejbVer |

	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
			| importer |
			
			bar value: 2.
			bar value: 'Parsing SQL file'.
			importer := MJSQLImporterFromVisitor new targetModel: self.
			importer importSQLCreateScriptFrom: ([ aFileStream contentsOfEntireFile ]
																				ensure: [ aFileStream close ]).
			
			"bar value: 3.
			bar value: 'Populate the model'.
			self populateWithRelationalElementsFrom: parser blackBoard."
			
			"self ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					self ejbVersion: ejbVer.]."

			bar value: 4.
			bar value: 'Building relations'.
			
			"self buildRelationsAmongDBTablesAndClasses.			
			self buildRelationsAmongTableColumnsAndMethods."
			
			bar value: 5].
	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importDBFromSQLFileUsingASTGUI [
	<menuItem: 'Import database from SQL file using AST' category: 'JEAs Importers'>
	
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[self importDBFromSQLFileUsingAST: file readStream].
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importEjbJarFromFolder: aString [
	
	| fileSystem entries directoryEntries parser factory doc root counter |
	
	fileSystem := FSFilesystem onDisk referenceTo: aString.
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

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importEjbJarFromFolderGUI [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'JEAs Importers'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importEjbJarFromFolder: folderName pathName.
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importJSPagesContainedInto: aFolderPath [
	
	| result fileSystem entries fileEntries counter |

	fileSystem := FSFilesystem onDisk referenceTo: aFolderPath.
	entries := FSCollectVisitor breadthFirst: fileSystem.
	
	fileEntries := entries select: [:entry | '^.*.jsp$' asRegexIgnoringCase matches: entry reference name ].

	counter := 1.			
	UIManager default
		displayProgress: 'Importing From jsp files'
		at: Sensor cursorPoint
		from: 1 
		to: fileEntries size
		during: [ :bar | 
			bar  value: counter.
			
			fileEntries do: [:entry |					
					 | fileStream parser |
					
					PPParserResource reset.
					parser := PPParserResource current parserAt: PetitJSPParser.
					
					fileStream := StandardFileStream readOnlyFileNamed: (entry reference name).
					result := parser parseJSPFrom: fileStream.
					
					self populateWithJSPsFrom:  parser blackboard.

					counter := counter + 1.
					bar value: counter.
				]].
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> importJSPagesContainedIntoAFolderGUI [

	<menuItem: 'Import JS Pages from folder' category: 'JEAs Importers'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importJSPagesContainedInto: folderName pathName.
]

{ #category : #'*Moose-JEE-Core-Model' }
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

{ #category : #'*Moose-JEE-Core-Model' }
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
				self withoutAnnounceAdd: bean ].

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
				self withoutAnnounceAdd: bean ].
	
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
				self withoutAnnounceAdd: bean].
	
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

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> isEJB21 [
	^self ejbVersion = #EJB21
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> isEJB30 [
	^self ejbVersion = #EJB30
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> populateSystemLayers [
	<menuItem: 'Populate system layers' category: 'JEAs Importers'>

	|  question strategy |

	question := UITheme builder questionWithoutCancel: 'Do you want to clean up previously created layers?'.
	question ifTrue: [self cleanUpLayers].   

	strategy := UITheme builder chooseDropList: 'Choose the strategy to populate the layers ' list: (MJLayeringStrategy allSubclasses).
	
	strategy  isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			| layeringStrategy |			
			layeringStrategy := strategy on: self.
			layeringStrategy instanciateLayers.].
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> populateWithJSPsFrom: aBlackBoard [

	MJJSPImporter new populate: self withJSPsFrom: aBlackBoard.
	
	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> populateWithRelationalElementsFrom: aBlackBoard [
	self deprecated: 'Use the importer with the AST instead' on:  '18 March 2011' in: nil.	

	MJSQLImporter new populate: self withRelationalElementsFrom: aBlackBoard.
	
	^self
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> withoutAnnounceAdd: anElement [ 
	 
	super add: anElement. 
	anElement privateSetMooseModel: self.
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> withoutAnnounceAddAll: entities [ 
	 
	entities do: [:each | self withoutAnnounceAdd: each].
	^entities
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> withoutAnnounceRemove: anElement [ 
	
	self entityStorage remove: anElement. 
	anElement privateSetMooseModel: nil. 
	self privateState flushGroups. 
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> withoutAnnounceRemoveAll: collection [ 
	
	 collection do: [:each | self withoutAnnounceRemove: each]. 
	
]
