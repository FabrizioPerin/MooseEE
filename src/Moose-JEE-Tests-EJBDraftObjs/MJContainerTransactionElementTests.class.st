Class {
	#name : #MJContainerTransactionElementTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-EJBDraftObjs'
}

{ #category : #'as yet unclassified' }
MJContainerTransactionElementTests >> testXmlTags [
	self assert: (MJContainerTransactionElement xmlTags isMemberOf: OrderedCollection).
	self assert: (MJContainerTransactionElement xmlTags first = 'container-transaction').
]
