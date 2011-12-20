Class {
	#name : #MJDPLIToLContainmentTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testAnnotation [
	self assert: MJDPLIToLContainment annotation == MJDPLIToLContainment.
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testFrom [
	| containmentLevel levelInstance levelInstance2 |
	
	containmentLevel := MJDPLIToLContainment new.
	levelInstance := MJDPLevelInstance new.
	levelInstance2 := MJDPLevelInstance new.
	
	containmentLevel levelInstance: levelInstance.
	
	self assert: (containmentLevel from isMemberOf: MJDPLevelInstance).
	self assert: containmentLevel from equals: levelInstance.
	
	containmentLevel levelInstance: levelInstance2.
	
	self assert: (containmentLevel from isMemberOf: MJDPLevelInstance).
	self assert: containmentLevel from equals: levelInstance2.
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testLevel [
	| level containmentLevel level2 |
	
	containmentLevel := MJDPLIToLContainment new.
	level := MJDPLevel new.
	level2 := MJDPLevel new.
	
	containmentLevel level: level.
	
	self assert: (containmentLevel level isMemberOf: MJDPLevel).
	self assert: containmentLevel level equals: level.
	
	containmentLevel level: level2.
	
	self assert: (containmentLevel level isMemberOf: MJDPLevel).
	self assert: containmentLevel level equals: level2.
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testLevelInstance [
	| containmentLevel levelInstance levelInstance2 |
	
	containmentLevel := MJDPLIToLContainment new.
	levelInstance := MJDPLevelInstance new.
	levelInstance2 := MJDPLevelInstance new.
	
	containmentLevel levelInstance: levelInstance.
	
	self assert: (containmentLevel levelInstance isMemberOf: MJDPLevelInstance).
	self assert: containmentLevel levelInstance equals: levelInstance.
	
	containmentLevel levelInstance: levelInstance2.
	
	self assert: (containmentLevel levelInstance isMemberOf: MJDPLevelInstance).
	self assert: containmentLevel levelInstance equals: levelInstance2.
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testMJDPLIToLContainmentCreation [
	| level levelInstance levelInstance2 containmentLevel |
	
	containmentLevel := MJDPLIToLContainment new.
	
	self assert: (containmentLevel isMemberOf: MJDPLIToLContainment). 
	self assert: containmentLevel level isNil.
	self assert: containmentLevel levelInstance isNil.
	 
	
	
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testTo [
	| level containmentLevel level2 |
	
	containmentLevel := MJDPLIToLContainment new.
	level := MJDPLevel new.
	level2 := MJDPLevel new.
	
	containmentLevel level: level.
	
	self assert: (containmentLevel to isMemberOf: MJDPLevel).
	self assert: containmentLevel to equals: level.
	
	containmentLevel level: level2.
	
	self assert: (containmentLevel to isMemberOf: MJDPLevel).
	self assert: containmentLevel to equals: level2.
]
