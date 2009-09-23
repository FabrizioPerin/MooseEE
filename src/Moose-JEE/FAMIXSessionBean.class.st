"
SessionBean represents a JEE Session Bean.
	
It is a subclass of JEEBean, wich means that it knows about which classes implement:
	- the implementationClass,
	- the homeInterface, and
	- the remoteInterface

In addition, it knows whether it is stateless or stateful, and it knows about the transaction type it is to deal with.
"
Class {
	#name : #FAMIXSessionBean,
	#superclass : #FAMIXEJBean,
	#instVars : [
		'sessionType',
		'transactionType'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXSessionBean class >> annotation [
	<MSEClass: 'SessionBean' super: #FAMIXEJBean>
	<package: 'FAMIX'>
	<MSEComment: 'SessionBean represents a JEE Session Bean.
	
It is a subclass of JEEBean, wich means that it knows about which classes implement:
	- the implementationClass,
	- the homeInterface, and
	- the remoteInterface

In addition, it knows whether it is stateless or stateful, and it knows about the transaction type it is to deal with.
	'>
]

{ #category : #accessing }
FAMIXSessionBean >> isStateful [
	<MSEProperty: #isStatefull type: #Boolean> <derived>
	^self sessionType = #Stateful
]

{ #category : #accessing }
FAMIXSessionBean >> isStateless [
	<MSEProperty: #isStateless type: #Boolean> <derived>
	^self sessionType = #Stateless
]

{ #category : #accessing }
FAMIXSessionBean >> sessionType [
	<MSEProperty: #sessionType type: #String>
	^sessionType
]

{ #category : #accessing }
FAMIXSessionBean >> sessionType: anObject [
	sessionType := anObject asSymbol
]

{ #category : #accessing }
FAMIXSessionBean >> transactionType [
	<MSEProperty: #transactionType type: #String>
	^transactionType
]

{ #category : #accessing }
FAMIXSessionBean >> transactionType: anObject [
	transactionType := anObject asSymbol
]
