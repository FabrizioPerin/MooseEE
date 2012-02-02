Extension { #name : #MooseModel }

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> allBlameFiles [
	<navigation: 'All Blame Files'>

	| group |
	
	group :=  self allWithType: MJBlameFile.
	group description: 'Blame Files'.
	^group
]

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> allClassAuthors [
	<navigation: 'All Class Authors'>

	| group |
	
	group :=  self allWithType: MJAuthor ofGroupClass: MJAuthorGroup.
	group description: 'Class Authors'.
	^group
]

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> cleanAllBlameFiles [
	<menuItem: 'Clean up all blame files' category: 'JEAs Utilities'>

	self silentlyRemoveAll: (self allWithType: MJBlameFile).
	self silentlyRemoveAll: (self allWithType: MJBlameClassAssociation).
	self allClasses do: #cleanAssociatedBlameFile.
	
	Smalltalk garbageCollect.
	
]

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> cleanAllClassAuthors [
	<menuItem: 'Clean up all class owners' category: 'JEAs Utilities'>

	self silentlyRemoveAll: (self allWithType: MJAuthor).
	self allBlameFiles do: [ :blameFile | blameFile lines do: [ :line | line author: nil ] ].
	
	Smalltalk garbageCollect.
	
]

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> importClassOwnershipFromSVNBlameFilesGUI [
	<menuItem: 'Import Class ownership from SVN blame files' category: 'JEAs Importers'>
	
	| importer aFolder |
	
	importer := MJSVNBalmeImporter on: self.
	importer importBlameFilesInAFolder.
	importer computeTheConnectionsWithClasses.

	^self
]

{ #category : #'*moose-jee-gitlog-model' }
MooseModel >> importClassOwnershipGUI [
	<menuItem: 'Import Class ownership from blame files' category: 'JEAs Importers'>
	
	| importer aFolder |
	
	importer := MJGitBlameImporter on: self.
	importer importBlameFilesInAFolder.

	^self
]
