Class {
	#name : #MJEntityElement,
	#superclass : #MJEJBeanElement,
	#category : #'Moose-JEE-EJBDraftObjs'
}

{ #category : #'instance creation' }
MJEntityElement class >> xmlTags [
	^OrderedCollection with: 'entity'
]

{ #category : #converting }
MJEntityElement >> createBeanFrom: aMooseModel [
	| bean |
	bean := MJFAMIXEntityBean new.
	bean persistenceType: self persistenceType.
	bean primaryKeyClass: (self primaryKeyClassFrom: aMooseModel).
	bean primaryKeyClass ifNotNil: [bean primaryKeyClass parentEJBBean: bean].
	^bean
]

{ #category : #accessing }
MJEntityElement >> persistenceType [

	^(self elements detect: [:each | each name = 'persistence-type']) strings first.
]

{ #category : #accessing }
MJEntityElement >> primaryKeyClassFrom: aMooseModel [

	^aMooseModel allClasses entityNamed: ((
		(self elements detect: [:x | x name = 'prim-key-class']) strings first
	) copyReplaceAll: '.' with: '::') asSymbol.
]
