Class {
	#name : #MJFAMIXBusinessLayerTests,
	#superclass : #MJFAMIXLayerTests,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXBusinessLayerTests >> testAnnotation [
	self assert: MJFAMIXBusinessLayer annotation == MJFAMIXBusinessLayer.
]

{ #category : #tests }
MJFAMIXBusinessLayerTests >> testPrintOn [
	| aStream businessLayer |
	
	aStream := ReadWriteStream on: ''.
	businessLayer := MJFAMIXBusinessLayer new.

	businessLayer printOn: aStream.

	self assert: aStream contents equals: 'Business (Layer)'.
]
