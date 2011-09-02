Class {
	#name : #MJEntityElementTests,
	#superclass : #MJEJBeanElementTests,
	#category : #'Moose-JEE-Tests-EJBDraftObjs'
}

{ #category : #'as yet unclassified' }
MJEntityElementTests >> testXmlTags [
	self assert: (MJEntityElement xmlTags isMemberOf: OrderedCollection).
	self assert: (MJEntityElement xmlTags first = 'entity').
]
