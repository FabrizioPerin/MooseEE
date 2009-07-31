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

{ #category : #accessing }
FAMIXEJBean >> homeInterface [
	^homeInterface
]

{ #category : #accessing }
FAMIXEJBean >> homeInterface: anObject [
	homeInterface := anObject
]

{ #category : #accessing }
FAMIXEJBean >> implementationClass [
	^implementationClass
]

{ #category : #accessing }
FAMIXEJBean >> implementationClass: anObject [
	implementationClass := anObject
]

{ #category : #accessing }
FAMIXEJBean >> remoteInterface [
	^remoteInterface
]

{ #category : #accessing }
FAMIXEJBean >> remoteInterface: anObject [
	remoteInterface := anObject
]
