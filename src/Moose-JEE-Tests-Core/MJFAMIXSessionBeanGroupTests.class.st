Class {
	#name : #MJFAMIXSessionBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXSessionBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXSessionBeanGroup annotation == MJFAMIXSessionBeanGroup.
]
