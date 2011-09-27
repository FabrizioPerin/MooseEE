Class {
	#name : #MJFAMIXMessageDrivenBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests-EJB'
}

{ #category : #tests }
MJFAMIXMessageDrivenBeanTests >> testAnnotation [
	self assert: MJFAMIXMessageDrivenBean annotation == MJFAMIXMessageDrivenBean.
]

{ #category : #tests }
MJFAMIXMessageDrivenBeanTests >> testTransactionType [
	| messageDrivenBean |
	
	messageDrivenBean := MJFAMIXMessageDrivenBean new.
	
	self assert: (messageDrivenBean transactionType = nil).
	
	messageDrivenBean transactionType: 'RequiresNew'.
	
	self assert: (messageDrivenBean transactionType = 'RequiresNew').

]
