Class {
	#name : #MJFAMIXLayerGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXLayerGroupTests >> testAnnotation [
	self assert: MJFAMIXLayerGroup annotation == MJFAMIXLayerGroup.
]
