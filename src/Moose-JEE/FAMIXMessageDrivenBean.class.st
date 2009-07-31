Class {
	#name : #FAMIXMessageDrivenBean,
	#superclass : #FAMIXEJBean,
	#instVars : [
		'transactionType'
	],
	#category : #'Moose-JEE'
}

{ #category : #accessing }
FAMIXMessageDrivenBean >> transactionType [
	^transactionType
]

{ #category : #accessing }
FAMIXMessageDrivenBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]
