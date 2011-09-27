Extension { #name : #MOShapeSelector }

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> DBTableShape [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; center; row; left.
	
	builder 
		x: 1 
		y: 1 
		add: (MORectangleShape new 
				text: [ :table | table name];
				fontSize: 10;
				textHorizontalPadding: 1).
	builder 
		x: 1 
		y: 2 
		add: (MORectangleShape new 
				text: [ :table | 
						(table columns sort:[:a :b | a name < b name]) asArray 
							inject: '' into: [ :sum :el | sum, el name, String cr]];
						textHorizontalPadding: 1).
	
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> layerShape [
	| builder |
		
	builder := MOFormsBuilder new.
	
	builder column; fill; pref; grow.
	builder row; fill; pref; grow; row; fill; pref; grow.
	builder x: 1 y: 1 add: (MORectangleShape new withText; text: [:layer | layer name]; fontSize: 10; textAlignment: #left).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: MOChildrenShape new.
	
	^view shape: builder shape
	
	
	
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> tableShape [
	| builder |
		
	builder := MOFormsBuilder new.
	
	builder column; fill; pref; grow.
	builder row; fill; pref; grow; row; fill; pref; grow.
	builder x: 1 y: 1 add: (MORectangleShape new text: [:table | table name]; fontSize: 10).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: MOChildrenShape new.
	
	^view shape: builder shape
	
	
	
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassDiagramLikeForTable [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill.
	
	"Work around with transaparent background to show which table is mapped or not"
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | 
		table inUse 
			ifTrue: ['']
			ifFalse: [table name]]; fillColor: Color transparent; fontColor: Color red; fontSize: 10; textAlignment: #center"; textHorizontalPadding: 2; textVerticalPadding: 2").
	
	builder x: 1 y: 1 add: (MORectangleShape new text: [ :table | 
		table inUse 
			ifTrue: [table name]
			ifFalse: ['']]; fillColor: Color transparent; fontSize: 10; textAlignment: #center"; textHorizontalPadding: 2; textVerticalPadding: 2").
			
			
	builder x: 1 y: 2 add: ((MORectangleShape new withBorder) text: [ :table |
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el |
			(el inUse not)
				ifTrue: [sum, el name, '  ', String cr]
				ifFalse: [sum]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText] ]; fontColor: Color red; "fontSize: 6;" textAlignment: #left"; textVerticalPadding: 2" ).
		
		
	builder x: 1 y: 3 add: ((MORectangleShape new withBorder) text: [ :table | 
		| localText |
		localText := (table columns asArray inject: '' into: [ :sum :el | 
			(el inUse)
				ifTrue: [sum, el name, '  ', String cr]
				ifFalse: [sum]
			]).
		localText isNil 
			ifTrue: [' ']
			ifFalse: [localText] ]; "fontSize: 6;" textAlignment: #left"; textVerticalPadding: 2" ).
	
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassShape [
	| builder |
		
	builder := MOFormsBuilder new.
	
	builder column; fill; pref; grow.
	builder row; fill; pref; grow; row; fill; pref; grow; row; fill; pref; grow.
	builder x: 1 y: 1 add: (MORectangleShape new text: [:class | class mooseDisplayString]; fontSize: 10).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: MOChildrenShape new.
	
	^view shape: builder shape
	
	
	
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassShapeGreen [
	| builder |
		
	builder := MOFormsBuilder new.
	
	builder column; fill; pref; grow.
	builder row; fill; pref; grow; row; fill; pref; grow; row; fill; pref; grow.
	builder x: 1 y: 1 add: (MORectangleShape new text: [:class | class mooseDisplayString]; fontSize: 10; fontColor: Color green muchDarker).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: MOChildrenShape new.
	
	^view shape: builder shape
	
	
	
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassWithAll [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill.
	builder x: 1 y: 1 add: ((MORectangleShape new withText) text: [ :cls | cls name ]; fontSize: 10; textPadding: 2; textAlignment: #center).
	builder x: 1 y: 2 add: (MORectangleShape new text: [ :cls | 
		cls attributes asArray inject: '' into: [ :sum :el | sum , el name , String cr ] ]; fontSize: 6; textVerticalPadding: 2; textAlignment: #left).
	builder x: 1 y: 3 add: (MORectangleShape new text: [ :cls | 
		cls methods asArray inject: '' into: [ :sum :el | sum , el name , String cr ] ]; fontSize: 6; textVerticalPadding: 2; textAlignment: #left).
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassWithAttributes [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill.
	builder x: 1 y: 1 add: ((MORectangleShape new withText) text: [ :cls | cls name ]; fontSize: 10; textPadding: 2; textAlignment: #center).
	builder x: 1 y: 2 add: (MORectangleShape new text: [ :cls | 
		cls attributes asArray inject: '' into: [ :sum :el | sum , el name , String cr ] ]; fontSize: 6; textVerticalPadding: 2; textAlignment: #left).
	builder x: 1 y: 3 add: (MORectangleShape new).
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Core-Model' }
MOShapeSelector >> umlClassWithMethods [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill; row; fill.
	builder x: 1 y: 1 add: ((MORectangleShape new withText) text: [ :cls | cls name ]; fontSize: 10; textPadding: 2; textAlignment: #center).
	builder x: 1 y: 2 add: (MORectangleShape new).
	builder x: 1 y: 3 add: (MORectangleShape new text: [ :cls | 
		cls methods asArray inject: '' into: [ :sum :el | sum , el name , String cr ] ]; fontSize: 6; textVerticalPadding: 2; textAlignment: #left).
	^ view shape: builder shape
]
