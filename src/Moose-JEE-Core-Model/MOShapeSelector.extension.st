Extension { #name : #MOShapeSelector }

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
