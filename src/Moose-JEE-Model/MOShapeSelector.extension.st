Extension { #name : #MOShapeSelector }

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> layerCalled: aString [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: MORectangleShape new.
	builder x: 1 y: 1 add: (MOLabelShape new text: aString).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: [:bean | view node: bean using:( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: bean mooseModel allClasses; withBorder ). view dominanceTreeLayout.].
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> layerCalled: aString on: beans [
	| builder |
	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: MORectangleShape new.
	builder x: 1 y: 1 add: (MOLabelShape new text: aString).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: [view nodes: beans using:( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ). view dominanceTreeLayout.].
	^ view shape: builder shape
]

{ #category : #'*Moose-JEE-Model' }
MOShapeSelector >> layerShape: aString [
	| builder |

	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: MORectangleShape new.
	builder x: 1 y: 1 add: (MOLabelShape new text: [aString value]).
	builder x: 1 y: 2 add: MORectangleShape new.
	^view shape: builder shape
]
