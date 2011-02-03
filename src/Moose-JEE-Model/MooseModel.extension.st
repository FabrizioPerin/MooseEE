Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allColumns [
	<navigation: 'All Table Columns'>
	
	| group |
	
	
	group := self allWithType: MJFAMIXColumn ofGroupClass: MJFAMIXColumnGroup.
	group description: 'All Table Columns'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allDataLayer [
	"it should always be one"
	^self allWithType: MJFAMIXDataLayer
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allDatabases [

	^self allWithType: MJFAMIXDataBase "asMetaDescription"
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allEntityBeans [
	<navigation: 'All Entity Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXEntityBean ofGroupClass: MJFAMIXEntityBeanGroup.
	group description: 'All Entity Beans'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allFKAssociations [
	<navigation: 'All FK associations'>

	| group |
	
	group :=  self allWithType: MJFAMIXFKAssociation.
	group description: 'All FK associations'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allJEEBeans [

	^self allSessionBeans, self allEntityBeans, self allMessageDrivenBeans.
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allJSPInvocations [
	<navigation: 'All JSPage Invocations'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPInvocation.
	group description: 'JSPage Invocations'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allJSPages [
	<navigation: 'All JSPages'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPPage.
	group description: 'JSPages'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allLayers [

	^self allPresentationLayer, self allLogicLayer, self allDataLayer, self allServiceLayer
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allLogicLayer [

	^self allWithType: MJFAMIXLogicLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allMaps [
	<navigation: 'All Maps'>

	| group |
	
	group :=  self allWithType: MJFAMIXMapping.
	group description: 'All Maps'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allMessageDrivenBeans [
	<navigation: 'All Message Driven Beans'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXMessageDrivenBean ofGroupClass: MJFAMIXMessageDrivenBeanGroup.
	group description: 'All Message Driven Beans'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allPresentationLayer [

	^self allWithType: MJFAMIXPresentationLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allServiceLayer [

	^self allWithType: MJFAMIXServiceLayer "asMetaDescription"
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allSessionBeans [
	<navigation: 'All Session Beans'>

	| group |
	
	group :=  self allWithType: MJFAMIXSessionBean ofGroupClass: MJFAMIXSessionBeanGroup.
	group description: 'All Session Beans'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allTables [
	<navigation: 'All Data Base Tables'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXTable ofGroupClass: MJFAMIXTableGroup.
	group description: 'All Data Base Tables'.
	^group
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> allTransactionalMethods [
	
	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> annotateTheModelForJEEBrowser [

	<menuItem: 'Annotate the model with JEE informations' category: 'JEAs Menu' >

	self createAnnotationForTransactionScope.
	self createAnnotationForUnsafeQuery.
	
	^self
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> browseCodeWithAnnotationsForJEA [
	<menuItem: 'Code Browser For JEA' category: 'JEAs Menu'>
	MooseBrowsers new codeBrowserForJEA openOn: self	
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> buildRelationsAmongDBTablesAndClasses [
	<menuItem: 'Build Relations Among Tables And Classes' category: 'JEAs Menu'>

	| tables tableEntities counter annotationTypeTable ejbVer |

	self ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					self ejbVersion: ejbVer.].
	self isEJB30 
	ifTrue:[	
		annotationTypeTable := (self allAnnotationTypes select: [:each | each name = 'Table']).
		annotationTypeTable isEmpty 
			ifFalse: [
				(annotationTypeTable size > 1)
					ifTrue: [
						tableEntities := UITheme builder 
								chooseDropList: 'Choose which element you want' list: annotationTypeTable asArray.
						tableEntities := tableEntities annotatedEntities]
					ifFalse: [tableEntities := annotationTypeTable first annotatedEntities.].
			tables := self allTables.
			counter :=  1.

			UIManager default
				displayProgress: 'Building relations among Tables and Classes'
				at: Sensor cursorPoint
				from: counter
				to: (tableEntities size * tables size)
				during: [ :bar |
					counter := counter+1.
					bar value: counter.
				
					tables do: [:table | 
						tableEntities do: [:class |
							"(table nameWithAnnotationAsRegex matches: class sourceText)"
							((class sourceText findString: ('@Table(name = "',table name,'"')) > 0)
								ifTrue:[ |mapping|
									mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
									class addMaps: mapping.
									table addMappedBy: mapping.
									self withoutAnnounceAdd: mapping.].
								counter := counter+1.
								bar value: counter.]]]]]
	ifFalse:[
		tableEntities := self allClasses select: [:class | class methods anySatisfy: #doesExecuteAQuery].
		tables := self allTables.
		counter :=  1.

		UIManager default
			displayProgress: 'Building relations among DB and Classes'
			at: Sensor cursorPoint
			from: counter
			to: (tableEntities size * tables size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.
			
				tables do: [:table | 
					tableEntities do: [:class |
						((class sourceText findString: table name) > 0)
								ifTrue:[ |mapping|
										mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
										class addMaps: mapping.
										table addMappedBy: mapping.
										self withoutAnnounceAdd: mapping.].
								counter := counter+1.
								bar value: counter.
								]]]].
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> buildRelationsAmongTableColumnsAndMethods [
	<menuItem: 'Build Relations Among Columns And Methods' category: 'JEAs Menu'>

	| attributes classes counter allIndexes ejbVer|

	self ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					self ejbVersion: ejbVer.].
	self isEJB30 
	ifTrue:[	
		attributes := (self allAnnotationTypes select: [:each | each name = #Column or: [each name = #GeneratedValue]]) flatCollect: [:each | each annotatedEntities ].
		classes := (attributes collect: [:each | each parentType ]) asSet.

		counter :=  1.
		
		UIManager default
			displayProgress: 'Building relations among Columns and Attributes'
			at: Sensor cursorPoint
			from: counter
			to: (attributes size * self allColumns size)
			during: [ :bar |
				counter := counter+1.
				bar value: counter.

				classes do: [:class |
					| source currentAtt currentCol dictionaryOfColumns dictionaryOfAttributes classAttributes tableColumns |
					source := class sourceText.
					dictionaryOfColumns := Dictionary new.
					dictionaryOfAttributes := Dictionary new.
					
					classAttributes := class attributes intersection: attributes.
					tableColumns := OrderedCollection new.
					class mappedRelationalEntities isEmpty ifFalse: [tableColumns := class mappedRelationalEntities first columns ].
					
					tableColumns do: [:column | 
						| ind |
						"(class name = 'CustomerClass' and: [column name = 'CM_CLASS_ID']) ifTrue: [self halt.]."
						ind := (source findString: ('@Column(name = "',column name,'"')).
						(ind = 0) ifFalse: [dictionaryOfColumns at: ind put: column]].
				
					classAttributes do: [:attr |
						| ind |
						ind := (source findString: (attr declaredType name,' ',attr name)).
						"ind := (('.* ',attr name,'.*') asRegex matches: source)."
						(ind = 0) ifFalse: [dictionaryOfAttributes at: ind put: attr]].
					
					allIndexes := OrderedCollection withAll: (dictionaryOfColumns keys).
					allIndexes addAll: dictionaryOfAttributes keys.
					allIndexes := allIndexes sorted.
					
					currentAtt := currentCol := nil.
					
					allIndexes do: [:ind |
						| mapping |
						
						"(class name = 'CustomerClass') ifTrue:[self halt]. "
						
						dictionaryOfColumns at: ind ifPresent: [:col | 
							currentCol := col].
					
						dictionaryOfAttributes at: ind ifPresent: [:att |
							currentAtt := att].
						
						(currentCol isNil not and: [currentAtt isNil not]) 
							ifTrue: [
								mapping := MJFAMIXMapping new mapTarget: currentCol; mapSource: currentAtt.
								currentAtt addMaps: mapping.
								currentCol addMappedBy: mapping.
								self withoutAnnounceAdd: mapping.
								currentAtt := currentCol := nil.].

						counter := counter+1.
						bar value: counter].
				]]].
]

{ #category : #'*Moose-JEE-Model' }
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

{ #category : #'*Moose-JEE-Model' }
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

{ #category : #'*Moose-JEE-Model' }
MooseModel >> ejbVersion [
	^self privateState attributeAt: #ejbVersion ifAbsent: [nil]

]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> ejbVersion: aSymbol [
	^self privateState attributeAt: #ejbVersion put: aSymbol
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> importDBFromSQLFile: aFileStream [
	
	| parser result ejbVer |

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
			
			self buildRelationsAmongDBTablesAndClasses.			
			self buildRelationsAmongTableColumnsAndMethods.
			
			bar value: 5].
	^self
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> importDBFromSQLFileGUI [
	<menuItem: 'Import database from SQL file' category: 'JEAs Menu'>
	
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[self importDBFromSQLFile: file readStream].
]

{ #category : #'*Moose-JEE-Model-Importers' }
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
							
					(root allChildren select: [:eachElement | eachElement class = MJSessionElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = MJEntityElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = MJMessageDrivenElement])  do: [:eachElement |
							eachElement populate: self].
					(root allChildren select: [:eachElement | eachElement class = MJContainerTransactionElement]) do: [:eachElement |
							eachElement populate: self].
					counter := counter + 1.
					bar value: counter.
				]].

]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> importEjbJarFromFolderGUI [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'JEAs Menu'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importEjbJarFromFolder: folderName pathName.
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> importJSPagesContainedInto: aFolderPath [
	
	| result fileSystem entries fileEntries counter |

	fileSystem := FSDiskFilesystem current referenceTo: aFolderPath.
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

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> importJSPagesContainedIntoAFolderGUI [

	<menuItem: 'Import JS Pages from folder' category: 'JEAs Menu'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importJSPagesContainedInto: folderName pathName.
]

{ #category : #'*Moose-JEE-Model-Importers' }
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

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> instanciateJBeansFromAnnotations [
	<menuItem: 'Import beans from annotations' category: 'JEAs Menu'>
	
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

{ #category : #'*Moose-JEE-Model' }
MooseModel >> isEJB21 [
	^self ejbVersion = #EJB21
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> isEJB30 [
	^self ejbVersion = #EJB30
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> populateWithJSPsFrom: aBlackBoard [

	MJJSPImporter new populate: self withJSPsFrom: aBlackBoard.
	
	^self
]

{ #category : #'*Moose-JEE-Model-Importers' }
MooseModel >> populateWithRelationalElementsFrom: aBlackBoard [

	MJSQLImporter new populate: self withRelationalElementsFrom: aBlackBoard.
	
	^self
]

{ #category : #'*Moose-JEE-Model' }
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
				"Trying to readapt also the path separator in the case that the imported mse file has been generated on another platform"
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

{ #category : #'*Moose-JEE-Model' }
MooseModel >> tryToFixFAMiXFileAnchorsGUI [
	<menuItem: 'Try to fix links with files' category: 'JEAs Menu'>

	| folder |
	
	folder := UITheme builder chooseDirectory: 'Choose the root folder for ', self name.
	"folder := FileDirectory on: aPathString"
	folder ifNotNil: [ self tryToFixFAMiXFileAnchorsFrom: folder].
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> withoutAnnounceAdd: anElement [ 
	 
	super add: anElement. 
	anElement privateSetMooseModel: self.
	^anElement
]

{ #category : #'*Moose-JEE-Model' }
MooseModel >> withoutAnnounceAddAll: entities [ 
	 
	entities do: [:each | self withoutAnnounceAdd: each].
	^entities
]
