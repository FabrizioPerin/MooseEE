Class {
	#name : #MJMessageDrivenElement,
	#superclass : #MJEJBeanElement,
	#category : #'Moose-JEE-EJBDraftObjs'
}

{ #category : #'instance creation' }
MJMessageDrivenElement class >> xmlTags [
	^OrderedCollection with: 'message-driven'
]

{ #category : #accessing }
MJMessageDrivenElement >> createBeanFrom: aMooseModel [
	| bean |
	bean := MJFAMIXMessageDrivenBean new.
	bean transactionType: self transactionType.
	^bean
]

{ #category : #accessing }
MJMessageDrivenElement >> transactionType [

	^self elements detect: [:each | each name = 'transaction-type'] ifOne: [:x | x strings first] ifNone: [nil]
]
