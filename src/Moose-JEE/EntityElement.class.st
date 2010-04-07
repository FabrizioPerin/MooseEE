Class {
	#name : #EntityElement,
	#superclass : #EJBBeanElement,
	#category : #'Moose-JEE-Opax'
}

{ #category : #'instance creation' }
EntityElement class >> xmlTags [
	^OrderedCollection with: 'entity'
]

{ #category : #converting }
EntityElement >> createBeanFrom: aMooseModel [
	| bean |
	bean := FAMIXEntityBean new.
	bean persistenceType: self persistenceType.
	bean primaryKeyClass: (self primaryKeyClassFrom: aMooseModel).
	bean primaryKeyClass ifNotNil: [bean primaryKeyClass parentEJBBean: bean].
	^bean
]

{ #category : #accessing }
EntityElement >> persistenceType [

	^(self children detect: [:each | each tag = 'persistence-type']) characters.
]

{ #category : #accessing }
EntityElement >> primaryKeyClassFrom: aMooseModel [

	^aMooseModel allClasses entityNamed: ((
		(self children detect: [:x | x tag = 'prim-key-class']) characters
	) copyReplaceAll: '.' with: '::') asSymbol.
]
