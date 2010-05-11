Class {
	#name : #MJFAMIXMessageDrivenBean,
	#superclass : #MJFAMIXEJBean,
	#instVars : [
		'transactionType'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXMessageDrivenBean class >> annotation [
	<MSEClass: 'MessageDrivenBean' super: #MJFAMIXEJBean>
	<package: 'FAMIX'>
]

{ #category : #accessing }
MJFAMIXMessageDrivenBean >> transactionType [
	^transactionType
]

{ #category : #accessing }
MJFAMIXMessageDrivenBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]