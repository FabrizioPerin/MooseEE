Class {
	#name : #SessionElement,
	#superclass : #EJBBeanElement,
	#category : #'Moose-JEE-Opax'
}

{ #category : #'instance creation' }
SessionElement class >> xmlTags [
	^OrderedCollection with: 'session'
]

{ #category : #accessing }
SessionElement >> createBeanFrom: aMooseModel [	
	| bean |
	bean := FAMIXSessionBean new.
	bean sessionType: self sessionType.
	bean transactionType: self transactionType.
	^bean
]

{ #category : #accessing }
SessionElement >> sessionType [

	^(self children detect: [:each | each tag = 'session-type']) characters.
]

{ #category : #accessing }
SessionElement >> transactionType [

	^(self children detect: [:each | each tag = 'transaction-type']) characters.
]
