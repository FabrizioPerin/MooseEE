Class {
	#name : #MJFAMIXBusinessLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXBusinessLayer class >> annotation [
	<MSEClass: #MJFAMIXBusinessLayer super: #MJFAMIXLayer>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXBusinessLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populateBusinessLayer: self  
	
]

{ #category : #'as yet unclassified' }
MJFAMIXBusinessLayer >> isBusinessLayer [
	^true
]

{ #category : #'as yet unclassified' }
MJFAMIXBusinessLayer >> name [
	^'Business Layer'
]
