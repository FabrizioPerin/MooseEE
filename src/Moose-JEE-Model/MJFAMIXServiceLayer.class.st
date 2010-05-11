Class {
	#name : #MJFAMIXServiceLayer,
	#superclass : #MJFAMIXBusinessLayer,
	#instVars : [
		'containedSessionBeans'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #accessing }
MJFAMIXServiceLayer >> containedSessionBeans [
	^containedSessionBeans
]

{ #category : #initialization }
MJFAMIXServiceLayer >> initialize [ 
	super initialize.
	containedSessionBeans := OrderedCollection new.
	
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXServiceLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll:( aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | method couldBeAnEntryPoint ] ]).
	containedSessionBeans addAll: (aMooseModel allSessionBeans collect: [:bean | bean implementationClass] ).
	
	
]
