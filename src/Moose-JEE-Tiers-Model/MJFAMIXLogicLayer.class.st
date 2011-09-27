Class {
	#name : #MJFAMIXLogicLayer,
	#superclass : #MJFAMIXBusinessLayer,
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLogicLayer class >> annotation [
	<MSEClass: #MJFAMIXLogicLayer super: #MJFAMIXBusinessLayer>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXLogicLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populateLogicLayer: self
]

{ #category : #'as yet unclassified' }
MJFAMIXLogicLayer >> name [
	^'Logic Layer'
]

{ #category : #'as yet unclassified' }
MJFAMIXLogicLayer >> selectClassesFrom: aMooseModel [
	
]
