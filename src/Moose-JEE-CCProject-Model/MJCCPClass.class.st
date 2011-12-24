Class {
	#name : #MJCCPClass,
	#superclass : #FAMIXEntity,
	#instVars : [
		'id',
		'numberOfLines',
		'numberOfFragments',
		'sources'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPClass >> id [
	^ id
]

{ #category : #accessing }
MJCCPClass >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MJCCPClass >> numberOfFragments [
	^ numberOfFragments
]

{ #category : #accessing }
MJCCPClass >> numberOfFragments: anObject [
	numberOfFragments := anObject
]

{ #category : #accessing }
MJCCPClass >> numberOfLines [
	^ numberOfLines
]

{ #category : #accessing }
MJCCPClass >> numberOfLines: anObject [
	numberOfLines := anObject
]

{ #category : #accessing }
MJCCPClass >> sources [
	^ sources
]

{ #category : #accessing }
MJCCPClass >> sources: anObject [
	sources := anObject
]
