Class {
	#name : #MJDPLevelInstance,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedLevels',
		'patternDefinition'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLevelInstance class >> annotation [
	<MSEClass: #MJDPLevelInstance super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> addContainedLevel: aMJDPLToLIContainment [
	self containedLevels add: aMJDPLToLIContainment.
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> containedLevels [
	<MSEProperty: #containedLevels type: #MJDPLIToLContainment opposite: #levelInstance> <multivalued>
	<MSEComment: 'group of level instances contained into this level'>
	
	^ containedLevels
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> containedLevels: aCollectionOfMJDPLIToLContainment [
	containedLevels value: aCollectionOfMJDPLIToLContainment.
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> initialize [
	super initialize.
	
	containedLevels := FMMultivalueLink on: self opposite: #levelInstance:.
	patternDefinition := FMMultivalueLink on: self opposite: #levelInstance:.
	
	^ self
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> patternDefinition [
	<MSEProperty: #patternDefinition type: #MJDPPatternInstanceAssoc opposite: #levelInstance>
	<MSEComment: 'Association to the pattern defition implemented by this level instance'>
	
	^patternDefinition
]

{ #category : #'as yet unclassified' }
MJDPLevelInstance >> patternDefinition: aMJDPPatternInstanceAssoc [
	
	self patternDefinition value: (OrderedCollection with: aMJDPPatternInstanceAssoc).
]
