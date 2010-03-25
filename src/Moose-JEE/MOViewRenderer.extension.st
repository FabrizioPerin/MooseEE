Extension { #name : #MOViewRenderer }

{ #category : #'*Moose-JEE' }
MOViewRenderer >> dominanceGrouppedTreeLayout [
	^self layout: MJDominanceTreeWithGroupsLayout new.
]

{ #category : #'*Moose-JEE' }
MOViewRenderer >> umlLikeShape: aString on: aBlock [

	| builder |

	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: (MOLabelShape new text: aString).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: aBlock.
	^builder shape
]

{ #category : #'*Moose-JEE' }
MOViewRenderer >> umlPackageShapeWithLabel: aBlock [
	| builder |
	builder := MOFormsBuilder new.
	builder row; pref; row; size: -1; row; fill; pref; grow; size: 15.
	builder column; pref; column; fill; pref; grow; size: 15.
	builder x: 1 y:1 add: ((MOLabelShape new text: aBlock)).
	builder x: 1 y: 3 w: 2 add: (MOFormsShape new).
	^self shape: builder shapes.
]

{ #category : #'*Moose-JEE' }
MOViewRenderer >> umlPackageShapeWithLabel: aBlock with:  aShape [
	| builder |
	builder := MOFormsBuilder new.
	builder row; pref; row; size: -1; row; fill; pref; grow; size: 15.
	builder column; pref; column; fill; pref; grow; size: 15.
	builder x: 1 y:1 add: ((MOLabelShape new text: aBlock)).
	builder x: 1 y: 3 w: 2 add: aShape.
	^self shape: builder shapes.
]

{ #category : #'*Moose-JEE' }
MOViewRenderer >> umlShape: aString [

	| builder |

	builder := MOFormsBuilder new.
	builder
		column;
		fill.
	builder
		row;
		fill;
		row;
		fill.
	builder 
		x: 1
		y: 1
		add: MORectangleShape new.
	builder 
		x: 1
		y: 1
		add: (MOLabelShape new text: aString).
	builder 
		x: 1
		y: 2
		add: MORectangleShape new.
	builder 
		x: 1
		y: 2
		add: (MOLabelShape new text: 
			[ :cls | 
			cls methodDict keys 
				inject: ''
				into: [ :sum :el | sum , el , String cr ] ]).
	^ builder shape

]
