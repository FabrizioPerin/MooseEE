Extension { #name : #MOViewRenderer }

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
