Class {
	#name : #MJFAMIXEntityBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXEntityBeanTests >> testAnnotation [
	self assert: MJFAMIXEntityBean annotation == MJFAMIXEntityBean.
]
