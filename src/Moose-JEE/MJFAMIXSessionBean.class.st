"
SessionBean represents a JEE Session Bean.
	
It is a subclass of JEEBean, wich means that it knows about which classes implement:
	- the implementationClass,
	- the homeInterface, and
	- the remoteInterface

In addition, it knows whether it is stateless or stateful, and it knows about the transaction type it is to deal with.
"
Class {
	#name : #MJFAMIXSessionBean,
	#superclass : #MJFAMIXEJBean,
	#instVars : [
		'sessionType',
		'transactionType'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MJFAMIXSessionBean class >> annotation [
	<MSEClass: 'SessionBean' super: #MJFAMIXEJBean>
	<package: 'FAMIX'>
	<MSEComment: 'SessionBean represents a JEE Session Bean.
	
It is a subclass of JEEBean, wich means that it knows about which classes implement:
	- the implementationClass,
	- the homeInterface, and
	- the remoteInterface

In addition, it knows whether it is stateless or stateful, and it knows about the transaction type it is to deal with.
	'>
]

{ #category : #testing }
MJFAMIXSessionBean >> isStateful [
	<MSEProperty: #isStatefull type: #Boolean> <derived>
	^self sessionType = #Stateful
]

{ #category : #testing }
MJFAMIXSessionBean >> isStateless [
	<MSEProperty: #isStateless type: #Boolean> <derived>
	^self sessionType = #Stateless
]

{ #category : #accessing }
MJFAMIXSessionBean >> sessionType [
	<MSEProperty: #sessionType type: #String>
	^sessionType
]

{ #category : #accessing }
MJFAMIXSessionBean >> sessionType: anObject [
	sessionType := anObject asSymbol
]

{ #category : #accessing }
MJFAMIXSessionBean >> transactionType [
	<MSEProperty: #transactionType type: #String>
	^transactionType
]

{ #category : #accessing }
MJFAMIXSessionBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]
