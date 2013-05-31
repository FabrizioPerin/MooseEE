Class {
	#name : #MJFAMIXServiceLayer,
	#superclass : #MJFAMIXBusinessLayer,
	#instVars : [
		'containedSessionBeans'
	],
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer class >> annotation [
	<MSEClass: #MJFAMIXServiceLayer super: #MJFAMIXBusinessLayer>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populateServiceLayer: self  
	
]

{ #category : #accessing }
MJFAMIXServiceLayer >> containedSessionBeans [
	^containedSessionBeans
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> initialize [ 
	super initialize.
	containedSessionBeans := OrderedCollection new.
	
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> isServiceLayer [
	^true
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> name [
	^'Service Layer'
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> selectClassesFrom: aMooseModel [

	containedElements addAll:( aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | method couldBeAnEntryPoint ] ]).
	containedSessionBeans addAll: (aMooseModel allSessionBeans collect: [:bean | bean implementationClass] ).
	
	
]
