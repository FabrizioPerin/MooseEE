Class {
	#name : #MJFAMIXBusinessLayerTests,
	#superclass : #MJFAMIXLayerTests,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXBusinessLayerTests >> testAnnotation [
	self assert: MJFAMIXBusinessLayer annotation == MJFAMIXBusinessLayer.
]
