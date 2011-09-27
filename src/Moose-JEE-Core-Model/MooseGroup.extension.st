Extension { #name : #MooseGroup }

{ #category : #'*Moose-JEE-Core-Model' }
MooseGroup >> rankAndOpenInMoose [
	<menuItem: 'Rank and Open in Moose'>

	(self respondsTo: #ranked)
		ifTrue: [MooseFinder openOn: self ranked]
		ifFalse: [MooseFinder openOn: self]
]
