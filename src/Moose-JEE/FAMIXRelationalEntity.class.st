Class {
	#name : #FAMIXRelationalEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'mappedBy'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity class >> annotation [
	<MSEClass: #RelationalEntity super: #FAMIXNamedEntity>
	<package: #FAMIX>
	<abstract>
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addMappedBy: aMapping [

	mappedBy add: aMapping

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> initialize [
	super initialize.
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:.
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mappedBy [

	<MSEProperty: #mappedBy type: #FAMIXMapping opposite: #mapTarget> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^mappedBy
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mappedBy: aMapping [
	
	mappedBy value: aMapping
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mapsNamedEntities [
	^self mapDirection: #mapSource on: self mooseModel allMaps 
]
