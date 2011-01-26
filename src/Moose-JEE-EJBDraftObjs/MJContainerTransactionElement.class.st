Class {
	#name : #MJContainerTransactionElement,
	#superclass : #XMLElement,
	#category : #'Moose-JEE-EJBDraftObjs'
}

{ #category : #'instance creation' }
MJContainerTransactionElement class >> xmlTags [
	^OrderedCollection with: 'container-transaction'
]

{ #category : #converting }
MJContainerTransactionElement >> beanFrom: aMooseModel [

	^aMooseModel allJEEBeans entityNamed:
		(self allElements detect: [:x | x name = 'ejb-name']) strings first asSymbol.
]

{ #category : #converting }
MJContainerTransactionElement >> methodPattern [

	^(self allElements detect: [:x | x name = 'method-name']) strings first.
]

{ #category : #converting }
MJContainerTransactionElement >> populate: aMooseModel [

	| bean |
	bean := self beanFrom: aMooseModel.
	bean isNil ifTrue: [^self]
			    ifFalse: [bean implementationClass isNil ifTrue: [^self].].
	bean implementationClass methods do: [:each |
		(self methodPattern match: each name) ifTrue: [
			each ejbTransactionType: (self transactionAttribute).
		]
	]
]

{ #category : #converting }
MJContainerTransactionElement >> transactionAttribute [

	^(self elements detect: [:x | x name = 'trans-attribute']) strings first.
]
