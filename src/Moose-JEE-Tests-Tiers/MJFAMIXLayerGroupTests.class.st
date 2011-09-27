Class {
	#name : #MJFAMIXLayerGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXLayerGroupTests >> testAnnotation [
	self assert: MJFAMIXLayerGroup annotation == MJFAMIXLayerGroup.
]
