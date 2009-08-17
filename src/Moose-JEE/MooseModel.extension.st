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
MooseModel >> importEjbJarFromFolder [

	<menuItem: 'Import ejb-jar xmls from folder' category: 'Import / Export'>

	| folderName folder parser root |
	
	self flag: #TODO test.
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].
	folder := folderName asFileName.
	(folder exists and: [folder isDirectory]) ifFalse: [DialogWindow alert: 'File not found.'. ^self].

	folder entries do: [ :each |
			(each exists and: [each isDirectory not] and: [ '*ejb*.xml' match: each asString ]) ifTrue: 
			[
				
				parser := OPOpaxHandler on: self simpleXmlSample readStream.
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
