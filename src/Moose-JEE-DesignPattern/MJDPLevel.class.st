Class {
	#name : #MJDPLevel,
	#superclass : #MJDPEntity,
	#instVars : [
		'parentLevel',
		'childLevels',
		'containerLevelInstances'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLevel class >> annotation [
	<MSEClass: #MJDPLevel super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPLevel >> addContainerLevelInstance: aLevelInstance [
	self containerLevelInstances add: aLevelInstance.
]

{ #category : #'as yet unclassified' }
MJDPLevel >> childLevels [
	<MSEProperty: #childLevels type: #MJDPLevel opposite: #parentLevel> <multivalued> <derived>
	<MSEComment: 'child levels of this level'>
	
	^childLevels
]

{ #category : #'as yet unclassified' }
MJDPLevel >> childLevels: aCollectionOfMJDPLevels [
	childLevels value: aCollectionOfMJDPLevels
	
]

{ #category : #'as yet unclassified' }
MJDPLevel >> containerLevelInstances [
	<MSEProperty: #containerLevelInstances type: #MJDPLIToLContainment opposite: #level> <multivalued>
	<MSEComment: 'group of level instances contained into this level'>
	^containerLevelInstances 
]

{ #category : #'as yet unclassified' }
MJDPLevel >> containerLevelInstances: aCollectionOfMJDPLIToLContainment [
	containerLevelInstances value: aCollectionOfMJDPLIToLContainment
]

{ #category : #'as yet unclassified' }
MJDPLevel >> initialize [
	super initialize.
	
	containerLevelInstances := FMMultivalueLink on: self opposite: #level:.
	
	childLevels := FMMultivalueLink on: self opposite: #parentLevel:.
	parentLevel := nil.
	
	^ self
]

{ #category : #'as yet unclassified' }
MJDPLevel >> isRoot [
	^self parentLevel isNil
]

{ #category : #'as yet unclassified' }
MJDPLevel >> parentLevel [
	<MSEProperty: #parentLevel type: #MJDPLevel opposite: #childLevels>
	<MSEComment: 'parent level of this level'>
	
	^parentLevel
]

{ #category : #'as yet unclassified' }
MJDPLevel >> parentLevel: aMJDPLevel [

	parentLevel := FMMultivalueLink 
		on: self
		update: #childLevels
		from: self parentLevel
		to: aMJDPLevel
]
