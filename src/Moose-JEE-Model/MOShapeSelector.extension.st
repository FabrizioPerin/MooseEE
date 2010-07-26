Extension { #name : #MOShapeSelector }

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> umlClassDiagramLikeForTable [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill; row; fill.
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | table name ]; fontSize: 10; textAlignment: #center; textHorizontalPadding: 2 ).
	
	builder x: 1 y: 2 add: ((MORectangleShape new withBorder) text: [ :table |
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el | 
			(el inUse isNil not and: [el inUse not])
				ifTrue: [sum , el name, '  ', String cr]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText] ]; fontColor: Color red; fontSize: 6; textAlignment: #left ).
	
	builder x: 1 y: 3 add: ((MORectangleShape new withBorder) text: [ :table |
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el | 
			(el inUse isNil or: [el inUse])
				ifTrue: [sum , el name, '  ', String cr]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText]
			]; fontSize: 6; textAlignment: #left ).
	
	^ view shape: builder shape
]
