Class {
	#name : #MJFAMIXEntityBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests-EJB'
}

{ #category : #tests }
MJFAMIXEntityBeanTests >> testAnnotation [
	self assert: MJFAMIXEntityBean annotation == MJFAMIXEntityBean.
]
