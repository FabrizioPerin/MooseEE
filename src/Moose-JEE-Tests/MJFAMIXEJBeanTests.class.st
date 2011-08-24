Class {
	#name : #MJFAMIXEJBeanTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXEJBeanTests >> testAnnotation [
	self assert: MJFAMIXEJBean annotation == MJFAMIXEJBean.
]
