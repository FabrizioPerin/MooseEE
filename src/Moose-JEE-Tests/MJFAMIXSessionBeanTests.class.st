Class {
	#name : #MJFAMIXSessionBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXSessionBeanTests >> testAnnotation [
	self assert: MJFAMIXSessionBean annotation == MJFAMIXSessionBean.
]
