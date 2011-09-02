Class {
	#name : #MJFAMIXJSPAttributeTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXJSPAttributeTests >> testAnnotation [
	self assert: MJFAMIXJSPPage annotation == MJFAMIXJSPPage.
]
