Extension { #name : #MOShapeSelector }

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> umlClassDiagramLikeForTable [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill; row; fill.
	
	"Work around with transaparent background to show which table is mapped or not"
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | 
		table inUse 
			ifTrue: ['']
			ifFalse: [table name]]; fillColor: Color transparent; fontColor: Color red; fontSize: 10; textAlignment: #center; textHorizontalPadding: 2; textVerticalPadding: 2).
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | 
		table inUse 
			ifTrue: [table name]
			ifFalse: ['']]; fillColor: Color transparent; fontSize: 10; textAlignment: #center; textHorizontalPadding: 2; textVerticalPadding: 2).
			
	
	builder x: 1 y: 2 add: ((MORectangleShape new withBorder) text: [ :table |
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el |
			(el inUse not)
				ifTrue: [sum, el name, '  ', String cr]
				ifFalse: [sum]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText] ]; fontColor: Color red; fontSize: 6; textAlignment: #left; textVerticalPadding: 2 ).
	
	builder x: 1 y: 3 add: ((MORectangleShape new withBorder) text: [ :table | 
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el | 
			(el inUse)
				ifTrue: [sum, el name, '  ', String cr]
				ifFalse: [sum]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText] ]; fontSize: 6; textAlignment: #left; textVerticalPadding: 2 ).
	
	^ view shape: builder shape
]
