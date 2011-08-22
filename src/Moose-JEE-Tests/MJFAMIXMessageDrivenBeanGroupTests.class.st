Class {
	#name : #MJFAMIXMessageDrivenBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXMessageDrivenBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXMessageDrivenBeanGroup annotation == MJFAMIXMessageDrivenBeanGroup.
]
