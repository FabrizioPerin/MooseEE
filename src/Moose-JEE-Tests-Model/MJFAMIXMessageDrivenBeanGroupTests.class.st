Class {
	#name : #MJFAMIXMessageDrivenBeanGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXMessageDrivenBeanGroupTests >> testAnnotation [
	self assert: MJFAMIXMessageDrivenBeanGroup annotation == MJFAMIXMessageDrivenBeanGroup.
]
