Class {
	#name : #MJFAMIXEntityBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-EJB'
}

{ #category : #tests }
MJFAMIXEntityBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXEntityBeanGroup annotation == MJFAMIXEntityBeanGroup.
]
