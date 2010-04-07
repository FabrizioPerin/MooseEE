Class {
	#name : #MessageDrivenElement,
	#superclass : #EJBBeanElement,
	#category : #'Moose-JEE-Opax'
}

{ #category : #'instance creation' }
MessageDrivenElement class >> xmlTags [
	^OrderedCollection with: 'message-driven'
]

{ #category : #accessing }
MessageDrivenElement >> createBeanFrom: aMooseModel [
	| bean |
	bean := FAMIXMessageDrivenBean new.
	bean transactionType: self transactionType.
	^bean
]

{ #category : #accessing }
MessageDrivenElement >> transactionType [

	^self children detect: [:each | each tag = 'transaction-type'] ifPresent: [:x | x characters] ifNone: [nil]
]
