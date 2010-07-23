Extension { #name : #MOShapeSelector }

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> umlClassDiagramLikeForTable [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | ' ', table name, ' ' ]; fontSize: 10; textAlignment: #center ).
	builder x: 1 y: 2 add: (MORectangleShape new text: [ :table |
		table columns asArray inject: '' into: [ :sum :el | sum , el name, '  ', String cr ] ]; fontSize: 6; textAlignment: #left ).
	^ view shape: builder shape
]
