Class {
	#name : #MJFAMIXLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXLayerTests >> testAnnotation [
	self assert: MJFAMIXLayer annotation == MJFAMIXLayer.
]
