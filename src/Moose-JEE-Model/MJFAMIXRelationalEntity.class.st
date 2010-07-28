Class {
	#name : #MJFAMIXRelationalEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'mappedBy'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity class >> annotation [
	<MSEClass: #RelationalEntity super: #FAMIXNamedEntity>
	<package: #'Moose-JEE-Model'>
	<abstract>
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> addMappedBy: aMapping [

	mappedBy add: aMapping

]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> initialize [
	super initialize.
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:.
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mappedBy [

	<MSEProperty: #mappedBy type: #MJFAMIXMapping opposite: #mapTarget> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^mappedBy
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mappedBy: aMapping [
	
	mappedBy value: aMapping
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mappedNamedEntities [
	^self mapDirection: #mapSource on: self mooseModel allMaps 
]
