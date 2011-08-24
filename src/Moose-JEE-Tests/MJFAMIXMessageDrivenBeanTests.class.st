Class {
	#name : #MJFAMIXMessageDrivenBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXMessageDrivenBeanTests >> testAnnotation [
	self assert: MJFAMIXMessageDrivenBean annotation == MJFAMIXMessageDrivenBean.
]
