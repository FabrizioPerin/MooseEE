Class {
	#name : #MJFAMIXLayerGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXLayerGroupTests >> testAnnotation [
	self assert: MJFAMIXLayerGroup annotation == MJFAMIXLayerGroup.
]
