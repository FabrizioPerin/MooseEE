Class {
	#name : #MJFAMIXLayerGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXLayerGroupTests >> testAnnotation [
	self assert: MJFAMIXLayerGroup annotation == MJFAMIXLayerGroup.
]
