Class {
	#name : #FAMIXMessageDrivenBean,
	#superclass : #FAMIXEJBean,
	#instVars : [
		'transactionType'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXMessageDrivenBean class >> annotation [
	<MSEClass: 'MessageDrivenBean' super: #FAMIXEJBean>
	<package: 'FAMIX'>
]

{ #category : #accessing }
FAMIXMessageDrivenBean >> transactionType [
	^transactionType
]

{ #category : #accessing }
FAMIXMessageDrivenBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]
