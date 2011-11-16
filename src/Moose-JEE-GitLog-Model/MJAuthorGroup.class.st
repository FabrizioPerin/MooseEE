Class {
	#name : #MJAuthorGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #'as yet unclassified' }
MJAuthorGroup class >> annotation [

	<MSEClass: #MJAuthorGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-GitLog-Model'>

]

{ #category : #'as yet unclassified' }
MJAuthorGroup >> showOwnershipDiagram [

	| diag |
	diag := ESDiagramRenderer new.
	(diag pieDiagram)
		borderWidth: 1;
		radius: 200;
		models: self;
		pieValue: #ownedLines;
		color: #yourself;
		legendOrigin: 0@400;
		legendWidth: 600;
		"verticalLegend;"
		displayLegend: true.

	^diag open
]
