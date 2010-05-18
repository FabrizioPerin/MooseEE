Class {
	#name : #ContainerTransactionElement,
	#superclass : #OPGenericElement,
	#category : #'Moose-JEE-Opax'
}

{ #category : #'instance creation' }
ContainerTransactionElement class >> xmlTags [
	^OrderedCollection with: 'container-transaction'
]

{ #category : #converting }
ContainerTransactionElement >> beanFrom: aMooseModel [

	^aMooseModel allJEEBeans entityNamed:
		(self allChildren detect: [:x | x tag = 'ejb-name']) characters asSymbol.
]

{ #category : #converting }
ContainerTransactionElement >> methodPattern [

	^(self allChildren detect: [:x | x tag = 'method-name']) characters.
]

{ #category : #converting }
ContainerTransactionElement >> populate: aMooseModel [

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
ContainerTransactionElement >> transactionAttribute [

	^(self children detect: [:x | x tag = 'trans-attribute']) characters.
]
