Class {
	#name : #MJFAMIXJSPPageTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXJSPPageTests >> testAnnotation [
	self assert: MJFAMIXJSPAttribute annotation == MJFAMIXJSPAttribute.
]
