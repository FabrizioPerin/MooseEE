Class {
	#name : #MJSessionElementTests,
	#superclass : #MJEJBeanElementTests,
	#category : #'Moose-JEE-Tests-EJBDraftObjs'
}

{ #category : #'as yet unclassified' }
MJSessionElementTests >> testXmlTags [
	self assert: (MJSessionElement xmlTags isMemberOf: OrderedCollection).
	self assert: (MJSessionElement xmlTags first = 'session').
]
