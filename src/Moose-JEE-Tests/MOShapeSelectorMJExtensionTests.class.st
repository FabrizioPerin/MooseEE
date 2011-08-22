Class {
	#name : #MOShapeSelectorMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MOShapeSelectorMJExtensionTests >> testDBTableShape [
	| shapeSelector shape builder firstAdaptor secondAdaptor window view |

	shapeSelector := MOViewRenderer new shape.
	
	self assert: (shapeSelector DBTableShape isMemberOf: MOFormsShape).
	self assert: ((shapeSelector builder shapes collect: [:sh | sh class]) asArray = {MOShapeAdaptor . MOShapeAdaptor}).
	
	"Adaptor for the rectangle shape"
	firstAdaptor := shape builder shapes first.
	self assert: (firstAdaptor component class == MORectangleShape ).
	
	"Adaptor for the children shape???? What the hell is that"
	secondAdaptor := shape builder shapes second.
	self assert: (secondAdaptor component class == MORectangleShape ).

	"Adaptor for the children shape"
"	thirdAdaptor := shape builder shapes third.
	self assert: (thirdAdaptor component class == MOChildrenShape ).
	self assert: (thirdAdaptor component parent isNil ).
	self assert: ((thirdAdaptor component instVarNamed: 'next') isNil ).
"	
	window := view open.

	"Adaptor for the children shape"
"	thirdAdaptor := shape builder shapes third.
	self assert: (thirdAdaptor component class == MOChildrenShape ).
	self assert: (thirdAdaptor component parent isNil ).
	self assert: ((thirdAdaptor component instVarNamed: 'next') isNil ).
"

]
