Class {
	#name : #MJSessionElement,
	#superclass : #MJEJBeanElement,
	#category : #'Moose-JEE-EJBDraftObjs'
}

{ #category : #'instance creation' }
MJSessionElement class >> xmlTags [
	^OrderedCollection with: 'session'
]

{ #category : #accessing }
MJSessionElement >> createBeanFrom: aMooseModel [	
	| bean |
	bean := MJFAMIXSessionBean new.
	bean sessionType: self sessionType.
	bean transactionType: self transactionType.
	^bean
]

{ #category : #accessing }
MJSessionElement >> sessionType [

	^(self elements detect: [:each | each name = 'session-type']) strings first.
]

{ #category : #accessing }
MJSessionElement >> transactionType [

	^(self elements detect: [:each | each name = 'transaction-type']) strings first.
]
