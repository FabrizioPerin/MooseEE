Class {
	#name : #MJCCPClassinfo,
	#superclass : #FAMIXEntity,
	#instVars : [
		'numberOfClasses',
		'numberOfClones',
		'numberOfFragments',
		'numberOfPairs'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPClassinfo >> numberOfClasses [
	^ numberOfClasses
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfClasses: anObject [
	numberOfClasses := anObject
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfClones [
	^ numberOfClones
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfClones: anObject [
	numberOfClones := anObject
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfFragments [
	^ numberOfFragments
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfFragments: anObject [
	numberOfFragments := anObject
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfPairs [
	^ numberOfPairs
]

{ #category : #accessing }
MJCCPClassinfo >> numberOfPairs: anObject [
	numberOfPairs := anObject
]
