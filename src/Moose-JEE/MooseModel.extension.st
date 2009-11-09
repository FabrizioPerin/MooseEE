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
	
	| annotations entityBeansAnnotations messageDrivenBeansAnnotations sessionBeansAnnotations sessionBeans aMooseModel |
	
	entityBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Entity'].
	messageDrivenBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	sessionBeansAnnotations := self allAnnotationInstances entities select: [:each | each annotationType name = 'Session'].
	
	entityBeansAnnotations do: [:annotation | 
									| bean |
									self haltOnce. 
									bean := FAMIXEntityBean new.
									self allClasses detect: [:class | class name: (annotation annotatedEntities name).] 
									].
	
	"sessionBeansAnnotations do: [:annotation |  annotation ]."

	"bean := self createBeanFrom: aMooseModel.
	bean name: self ejbName.
	bean remoteInterface: (self remoteInterfaceFrom: aMooseModel).
	bean remoteInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean homeInterface: (self homeInterfaceFrom: aMooseModel).
	bean homeInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean implementationClass: (self implementationClassFrom: aMooseModel).
	bean implementationClass ifNotNil: [:cls | cls parentEJBBean: bean].
	aMooseModel add: bean.
	^bean"
]
