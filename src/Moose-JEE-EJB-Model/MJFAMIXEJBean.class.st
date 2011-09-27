Class {
	#name : #MJFAMIXEJBean,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'homeInterface',
		'remoteInterface',
		'implementationClass'
	],
	#category : #'Moose-JEE-EJB-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXEJBean class >> annotation [
	<MSEClass: #MJFAMIXEJBean super: #FAMIXNamedEntity>
	<package: #'Moose-JEE-Model'>
	<abstract>
]

{ #category : #accessing }
MJFAMIXEJBean >> belongsTo [ 
	^''
]

{ #category : #accessing }
MJFAMIXEJBean >> homeInterface [
	<MSEProperty: #homeInterface type: #FAMIXClass>
	^homeInterface
]

{ #category : #accessing }
MJFAMIXEJBean >> homeInterface: anObject [
	homeInterface := anObject
]

{ #category : #accessing }
MJFAMIXEJBean >> implementationClass [
	<MSEProperty: #implementingClass type: #FAMIXClass>
	^implementationClass
]

{ #category : #accessing }
MJFAMIXEJBean >> implementationClass: anObject [
	implementationClass := anObject
]

{ #category : #accessing }
MJFAMIXEJBean >> remoteInterface [
	<MSEProperty: #remoteInterface type: #FAMIXClass>
	^remoteInterface
]

{ #category : #accessing }
MJFAMIXEJBean >> remoteInterface: anObject [
	remoteInterface := anObject
]
