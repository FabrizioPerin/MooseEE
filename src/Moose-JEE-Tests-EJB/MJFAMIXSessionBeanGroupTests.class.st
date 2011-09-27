Class {
	#name : #MJFAMIXSessionBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-EJB'
}

{ #category : #tests }
MJFAMIXSessionBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXSessionBeanGroup annotation == MJFAMIXSessionBeanGroup.
]
