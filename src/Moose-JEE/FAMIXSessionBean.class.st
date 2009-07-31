Class {
	#name : #FAMIXSessionBean,
	#superclass : #FAMIXEJBean,
	#instVars : [
		'sessionType',
		'transactionType'
	],
	#category : #'Moose-JEE'
}

{ #category : #accessing }
FAMIXSessionBean >> isStateful [
	^self sessionType = #Stateful
]

{ #category : #accessing }
FAMIXSessionBean >> isStateless [
	^self sessionType = #Stateless
]

{ #category : #accessing }
FAMIXSessionBean >> sessionType [
	^sessionType
]

{ #category : #accessing }
FAMIXSessionBean >> sessionType: anObject [
	sessionType := anObject asSymbol
]

{ #category : #accessing }
FAMIXSessionBean >> transactionType [
	^transactionType
]

{ #category : #accessing }
FAMIXSessionBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]
