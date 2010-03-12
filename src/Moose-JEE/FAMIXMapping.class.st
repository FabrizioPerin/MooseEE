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
	#name : #FAMIXMapping,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'maps',
		'mapped'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXMapping class >> annotation [
	<MSEClass: #DBMapping super: 'FAMIX.Association'>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> from [

	^ self maps
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> initialize [
	super initialize.
	"maps := FMMultivalueLink on: self opposite: #defines:.
	mapped := FMMultivalueLink on: self opposite: #definedBy:."
	
	maps:=nil.
	mapped:=nil.
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapped [
	<MSEProperty: #mapped type: #FAMIXRelationalEntity opposite: #definedBy>
	<MSEComment: 'Relational element mapped into the system by a Named Entity.'>
	
	^mapped
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapped: aRelationalEntity [

	mapped := FMMultivalueLink 
								on: self
								update: #definedBy
								from: self mapped
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> maps [

	<MSEProperty: #maps type: #FAMIXNamedEntity opposite: #defines>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^maps
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> maps: aNamedEntity [
	
	maps := FMMultivalueLink 
								on: self
								update: #defines
								from: self maps
								to: aNamedEntity
	
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (Maps)'
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> to [

	^ self mapped
]
