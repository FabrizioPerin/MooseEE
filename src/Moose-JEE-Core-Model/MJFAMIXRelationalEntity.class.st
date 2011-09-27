Class {
	#name : #MJFAMIXRelationalEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'mappedBy',
		'references',
		'referencedBy',
		'sourceAccessors'
	],
	#category : #'Moose-JEE-Core-Model'
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
MJFAMIXRelationalEntity >> addReferencedBy: aForeignKeyAssoc [

	referencedBy add: aForeignKeyAssoc

]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> addReferences: aForeignKeyAssoc [

	references add: aForeignKeyAssoc

]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> addSourceAccessors: aDBAccess [

	sourceAccessors add: aDBAccess

]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> belongsTo [ 
	^''
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> initialize [
	super initialize.
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:.
	references := FMMultivalueLink on: self opposite: #sourceColumn:.
	referencedBy := FMMultivalueLink on: self opposite: #targetColumn:.
	sourceAccessors := FMMultivalueLink on: self opposite: #accessedEntity:.
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mappedBy [

	<MSEProperty: #mappedBy type: #MJFAMIXMapping opposite: #mapTarget> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^mappedBy
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mappedNamedEntities [
	^self mapDirection: #mapSource on: self mooseModel allMaps 
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> mooseNameOn: aStream [ 
	
	aStream nextPutAll: self name.
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> referencedBy [

	<MSEProperty: #referencedBy type: #MJFAMIXFKAssociation opposite: #targetColumn> <multivalued> <derived>
	<MSEComment: 'Foreign Key constrait.'>
	
	^referencedBy 
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> references [

	<MSEProperty: #references type: #MJFAMIXFKAssociation opposite: #sourceColumn> <multivalued> <derived>
	<MSEComment: 'Foreign Key constrait.'>
	
	^references
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> removePointersToMaps [
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:
]

{ #category : #'as yet unclassified' }
MJFAMIXRelationalEntity >> sourceAccessors [
	<MSEProperty: #sourceAccessors type: #MJFAMIXDBAccess opposite: #accessedEntity> <multivalued> <derived>
	<MSEComment: 'DB Access relationship.'>
	
	^sourceAccessors

]
