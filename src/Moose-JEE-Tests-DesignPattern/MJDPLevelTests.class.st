Class {
	#name : #MJDPLevelTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLevelTests class >> annotation [
	<MSEClass: #MJDPLevel super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> addContainedLevel: aLevelInstance [
	self contains add: aLevelInstance.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> contains [
	<MSEProperty: #contains type: #MJDPLevelInstance opposite: #contained> <multivalued>
	<MSEComment: 'group of level instances contained into this level'>
	
	^ containedLevels
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> contains: aLevelInstance [
	containedLevels value: aLevelInstance.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> initialize [
	super initialize.
	
	containedLevels := FMMultivalueLink on: self opposite: #containers:.
	
	^self
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testMKDPLevelCreation [
	| level |

	level := MJDPLevel new.
	
	self assert: (level isMemberOf: MJDPLevel).
	self assert: (level contains isMemberOf: FMMultivalueLink).
	self assert: level contains isEmpty.
	
]
