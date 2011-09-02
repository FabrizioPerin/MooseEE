Class {
	#name : #MJFAMIXEJBeanTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXEJBeanTests >> testAnnotation [
	self assert: MJFAMIXEJBean annotation == MJFAMIXEJBean.
]

{ #category : #tests }
MJFAMIXEJBeanTests >> testBelongsTo [
	self assert: MJFAMIXEJBean new belongsTo = ''.
]
