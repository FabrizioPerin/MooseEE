Class {
	#name : #MJFAMIXJSPAttributeTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXJSPAttributeTests >> testAnnotation [
	self assert: MJFAMIXJSPPage annotation == MJFAMIXJSPPage.
]
