Class {
	#name : #FAMIXServiceLayer,
	#superclass : #FAMIXBusinessLayer,
	#instVars : [
		'containedSessionBeans'
	],
	#category : #'Moose-JEE'
}

{ #category : #accessing }
FAMIXServiceLayer >> containedSessionBeans [
	^containedSessionBeans
]

{ #category : #initialization }
FAMIXServiceLayer >> initialize [ 
	super initialize.
	containedSessionBeans := OrderedCollection new.
	
	^self
]

{ #category : #'as yet unclassified' }
FAMIXServiceLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll:( aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | method couldBeAnEntryPoint ] ]).
	containedSessionBeans addAll: (aMooseModel allSessionBeans collect: [:bean | bean implementationClass] ).
	
	
]
