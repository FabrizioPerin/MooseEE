Class {
	#name : #MJFAMIXEntityBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXEntityBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXEntityBeanGroup annotation == MJFAMIXEntityBeanGroup.
]
