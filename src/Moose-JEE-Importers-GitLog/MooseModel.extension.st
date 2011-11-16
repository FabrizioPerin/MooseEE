Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-gitlog' }
MooseModel >> allBlameFiles [
	<navigation: 'All Blame Files'>

	| group |
	
	group :=  self allWithType: MJBlameFile.
	group description: 'Blame Files'.
	^group
]

{ #category : #'*moose-jee-importers-gitlog' }
MooseModel >> allClassAuthors [
	<navigation: 'All Class Authors'>

	| group |
	
	group :=  self allWithType: MJAuthor ofGroupClass: MJAuthorGroup.
	group description: 'Class Authors'.
	^group
]
