Class {
	#name : #MJFAMIXSessionBeanTests,
	#superclass : #MJFAMIXEJBeanTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXSessionBeanTests >> testAnnotation [
	self assert: MJFAMIXSessionBean annotation == MJFAMIXSessionBean.
]

{ #category : #tests }
MJFAMIXSessionBeanTests >> testTransactionType [
	| sessionBean |
	
	sessionBean := MJFAMIXSessionBean new.
	
	self assert: (sessionBean transactionType = nil).
	
	sessionBean transactionType: 'RequiresNew'.
	
	self assert: (sessionBean transactionType = 'RequiresNew').

]
