Class {
	#name : #FAMIXLogicLayer,
	#superclass : #FAMIXBusinessLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXLogicLayer >> populate [
	containedClasses addAll: [ self mooseModel allClasses ].
]
