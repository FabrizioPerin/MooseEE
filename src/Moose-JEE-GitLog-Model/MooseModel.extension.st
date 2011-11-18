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
MooseModel >> importClassOwnershipGUI [
	<menuItem: 'Import Class ownership from blame files' category: 'JEAs Importers'>
	
	| importer aFolder |
	
	importer := MJGitBlameImporter on: self.
	importer importBlameFilesInAFolder.

	^self
]
