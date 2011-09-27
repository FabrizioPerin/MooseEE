"
FAMIXMapping represents the relation between a FAMIXClass or a FAMIXAttribute and a Database table and its fields. A FAMIXClass maps in a Table and a FAMIXAttribute map in a column.

Instance Variables
	mapped:		a FMMultivalueLink containing relational entities
	maps:		a FMMultivalueLink containing named entities

mapped
	- xxxxx

maps
	- xxxxx

"
Class {
	#name : #MJFAMIXMapping,
	#superclass : #MJAssociation,
	#instVars : [
		'mapSource',
		'mapTarget'
	],
	#category : #'Moose-JEE-SQL-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXMapping class >> annotation [
	<MSEClass: #MJFAMIXMapping super: #MJAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> from [

	^ self mapSource
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> initialize [
	super initialize.
	"maps := FMMultivalueLink on: self opposite: #defines:.
	mapped := FMMultivalueLink on: self opposite: #definedBy:."
	
	mapSource:=nil.
	mapTarget:=nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> mapSource [

	<MSEProperty: #mapSource type: #FAMIXNamedEntity opposite: #maps>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^mapSource
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> mapSource: aNamedEntity [
	
	mapSource := FMMultivalueLink 
								on: self
								update: #maps
								from: self mapSource
								to: aNamedEntity
	
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> mapTarget [
	<MSEProperty: #mapTarget type: #MJFAMIXRelationalEntity opposite: #mappedBy>
	<MSEComment: 'Relational element mapped into the system by a Named Entity.'>
	
	^mapTarget
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> mapTarget: aRelationalEntity [

	mapTarget := FMMultivalueLink 
								on: self
								update: #mappedBy
								from: self mapTarget
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (Maps)'
]

{ #category : #'as yet unclassified' }
MJFAMIXMapping >> to [

	^ self mapTarget
]
