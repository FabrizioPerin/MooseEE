Class {
	#name : #MOShapeSelectorMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #'as yet unclassified' }
MOShapeSelectorMJExtensionTests >> testDBTableShape [

	| shapeSelector dbTableShape firstAdaptor secondAdaptor window view |
	shapeSelector := MOViewRenderer new shape.
	dbTableShape := shapeSelector DBTableShape.
	
	self assert: (dbTableShape isMemberOf: MOFormsShape).
	self assert: ((dbTableShape builder shapes collect: [:sh | sh class]) asArray = {MOShapeAdaptor . MOShapeAdaptor}).
	
	"Adaptor for the rectangle shape"
	firstAdaptor := dbTableShape builder shapes first.
	self assert: (firstAdaptor component class == MORectangleShape ).
	
	"Adaptor for the children shape???? What the hell is that"
	secondAdaptor := dbTableShape builder shapes second.
	self assert: (secondAdaptor component class == MORectangleShape ).

]
