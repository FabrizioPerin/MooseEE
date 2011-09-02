Class {
	#name : #MJMessageDrivenElementTests,
	#superclass : #MJEJBeanElementTests,
	#category : #'Moose-JEE-Tests-EJBDraftObjs'
}

{ #category : #'as yet unclassified' }
MJMessageDrivenElementTests >> testXmlTags [
	self assert: (MJMessageDrivenElement xmlTags isMemberOf: OrderedCollection).
	self assert: (MJMessageDrivenElement xmlTags first = 'message-driven').
]
