Class {
	#name : #MJFAMIXLogicLayer,
	#superclass : #MJFAMIXBusinessLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MJFAMIXLogicLayer >> populate [
	containedClasses addAll: [ self mooseModel allClasses ].
]
