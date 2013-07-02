Extension { #name : #MooseGroup }

{ #category : #'*Moose-JEE-Core-Model' }
MooseGroup >> exportContentAsList [
	<menuItem: 'Export content as list on file' category: 'Import / Export'> 
	| aStream |
	
	aStream := StandardFileStream forceNewFileNamed: (self name asString , '.txt').
	[self exportContentAsListOn: aStream]
		ensure: [ aStream close]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseGroup >> exportContentAsListOn: aStream [

	(self sorted: [:a :b | a name < b name ])  
		do: [:table | 
			aStream nextPutAll: table name.
			aStream nextPutAll: String cr ].

]

{ #category : #'*Moose-JEE-Core-Model' }
MooseGroup >> rankAndOpenInMoose [
	<menuItem: 'Rank and Open in Moose'>

	(self respondsTo: #ranked)
		ifTrue: [MooseFinder openOn: self ranked]
		ifFalse: [MooseFinder openOn: self]
]
