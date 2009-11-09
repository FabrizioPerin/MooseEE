Extension { #name : #MooseModel }

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
MooseModel >> allTransactionalMethods [
	<navigation: 'All methods involved in EJB transactions'>

	^self allMethods select: #hasEJBTransactionAttribute
]

{ #category : #'*Moose-JEE' }
MooseModel >> bookmarkNamed: aSymbol ifAbsent: aBlock [

	^self bookmarks detect: [:each | each mooseName = aSymbol ] ifNone: aBlock
]

{ #category : #'*Moose-JEE' }
MooseModel >> importDataBaseFromSQLFile [
	<
	menuItem: 'Import database from SQL file'
	category: 'Import / Export'>
	| file parser result stream |
	self flag: #TODO test.
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql' ).
	file exists ifFalse: 
		[ DialogWindow alert: 'File not found.'.
		^ self ].
	parser := PGSQLParser new stream: file readStream.
	result := parser run.
	stream close

	"folder entries do: [ :each |
			(each exists and: [each isDirectory not] and: [ '*.sql' match: each asString ]) ifTrue: 
			[
				
				parser := PGSQLParserNew new stream: stream. OPOpaxHandler on: self simpleXmlSample readStream.
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
			]
	]"
]

{ #category : #'*Moose-JEE' }
MooseModel >> importEjbJarFromFolder [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'Import / Export'>

	| folderName parser root |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].
	
	folderName fileNames do: [:n | 
				| file |

				file := (FileStream readOnlyFileNamed: (folderName fullNameFor: n)).
				(n matchesRegex: '^.+\.(xml)$') ifTrue: 
						[
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
					]
			]
]

{ #category : #'*Moose-JEE' }
MooseModel >> instanciateJBeansFromAnnotations [
	<menuItem: 'Import beans from annotations' category: 'Import / Export'>
	
	| entityBeansAnnotations messageDrivenBeansAnnotations sessionBeansAnnotations |
	
	entityBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Entity'].
	messageDrivenBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	sessionBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Session'].

	entityBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXEntityBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class name = (annotation annotatedEntity name).] ) do: [:each | each parentEJBBean: bean].
		self add: bean ].
	
	messageDrivenBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXMessageDrivenBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class name = (annotation annotatedEntity name).] ) do: [:each | each parentEJBBean: bean].
		self add: bean ].
	
	sessionBeansAnnotations do: [:annotation | 
		| bean |
		bean := FAMIXSessionBean new name: annotation mooseName.
		( self allClasses select: [:class |
			class name = (annotation annotatedEntity name).] ) do: [:each | each parentEJBBean: bean].
		self add: bean ].
	
	^self
]
