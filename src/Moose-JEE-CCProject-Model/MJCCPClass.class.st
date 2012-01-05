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
MJCCPClass >> addAllSources: aCollectionOfMJCCPSource [
	self sources addAll: aCollectionOfMJCCPSource. 
]

{ #category : #accessing }
MJCCPClass >> addSource: aMJCCPSource [
	self sources add: aMJCCPSource. 
]

{ #category : #accessing }
MJCCPClass >> id [
	^ id
]

{ #category : #accessing }
MJCCPClass >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MJCCPClass >> initialize [
	super initialize.
 
	sources := FMMultivalueLink on: self opposite: #cloneClass:.
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
	<MSEProperty: #sources type: #MJCCPSource opposite: #cloneClass> <multivalued> <derived>
	<MSEComment: 'Contains all peaces of a clone class'>
	
	^ sources
]
