Class {
	#name : #MJFAMIXSessionBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXSessionBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXSessionBeanGroup annotation == MJFAMIXSessionBeanGroup.
]
