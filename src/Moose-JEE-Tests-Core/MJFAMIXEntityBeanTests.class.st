Class {
	#name : #MJFAMIXEntityBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXEntityBeanTests >> testAnnotation [
	self assert: MJFAMIXEntityBean annotation == MJFAMIXEntityBean.
]
