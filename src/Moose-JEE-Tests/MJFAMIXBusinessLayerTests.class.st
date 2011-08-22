Class {
	#name : #MJFAMIXBusinessLayerTests,
	#superclass : #MJFAMIXLayerTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXBusinessLayerTests >> testAnnotation [
	self assert: MJFAMIXBusinessLayer annotation == MJFAMIXBusinessLayer.
]
