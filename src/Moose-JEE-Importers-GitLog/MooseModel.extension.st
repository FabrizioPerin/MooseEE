Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-gitlog' }
MooseModel >> allClassAuthors [
	<navigation: 'All Class Authors'>

	| group |
	
	group :=  self allWithType: MJAuthor.
	group description: 'Class Authors'.
	^group
]
