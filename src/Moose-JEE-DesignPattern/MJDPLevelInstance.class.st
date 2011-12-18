Class {
	#name : #MJDPLevelInstance,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedLevels'
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
MJDPLevelInstance >> addContainers: aMJDPLevel [
	self containers add: aMJDPLevel.
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
	
	^ self
]
