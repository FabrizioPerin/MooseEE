Class {
	#name : #FAMIXRelationalEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'definedBy'
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
FAMIXRelationalEntity >> addDefinedBy: aMapping [

	definedBy add: aMapping

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> definedBy [

	<MSEProperty: #definedBy type: #FAMIXMapping opposite: #mapped> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^definedBy
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> definedBy: aMapping [
	
	definedBy value: aMapping
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> initialize [
	super initialize.
	definedBy := FMMultivalueLink on: self opposite: #mapped:.
]
