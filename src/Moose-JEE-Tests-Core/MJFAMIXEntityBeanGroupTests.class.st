Class {
	#name : #MJFAMIXEntityBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXEntityBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXEntityBeanGroup annotation == MJFAMIXEntityBeanGroup.
]
