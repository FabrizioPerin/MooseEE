Class {
	#name : #FAMIXEJBean,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'homeInterface',
		'remoteInterface',
		'implementationClass'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXEJBean class >> annotation [
	<MSEClass: 'JEBean' super: #FAMIXNamedEntity>
	<package: 'FAMIX'>
	<abstract>
]

{ #category : #accessing }
FAMIXEJBean >> homeInterface [
	<MSEProperty: #homeInterface type: #FAMIXClass>
	^homeInterface
]

{ #category : #accessing }
FAMIXEJBean >> homeInterface: anObject [
	homeInterface := anObject
]

{ #category : #accessing }
FAMIXEJBean >> implementationClass [
	<MSEProperty: #implementingClass type: #FAMIXClass>
	^implementationClass
]

{ #category : #accessing }
FAMIXEJBean >> implementationClass: anObject [
	implementationClass := anObject
]

{ #category : #accessing }
FAMIXEJBean >> remoteInterface [
	<MSEProperty: #remoteInterface type: #FAMIXClass>
	^remoteInterface
]

{ #category : #accessing }
FAMIXEJBean >> remoteInterface: anObject [
	remoteInterface := anObject
]
