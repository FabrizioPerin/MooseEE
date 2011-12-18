Class {
	#name : #MJDPLevelInstanceTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests class >> annotation [
	<MSEClass: #MJDPLevelInstance super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests >> testAddContainedLevels [
	| levelInstance containmentRelation |

	levelInstance :=  MJDPLevelInstance new.
	containmentRelation := MJDPLIToLContainment new.
	
	self assert: levelInstance containedLevels isEmpty.
	
	levelInstance addContainedLevel: containmentRelation.
	
	self assert: (levelInstance containedLevels isMemberOf: FMMultivalueLink).
	self assert: levelInstance containedLevels size equals: 1.
	self assert: levelInstance containedLevels first equals: containmentRelation.
	
]

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests >> testAnnotation [
	self assert: MJDPLevelInstance annotation == MJDPLevelInstance.
]

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests >> testContainedLevels [
	| levelInstance containmentRelation |

	levelInstance :=  MJDPLevelInstance new.
	containmentRelation := MJDPLIToLContainment new.
	
	self assert: levelInstance containedLevels isEmpty.
	
	levelInstance containedLevels: (OrderedCollection with: containmentRelation).
	
	self assert: (levelInstance containedLevels isMemberOf: FMMultivalueLink).
	self assert: levelInstance containedLevels size equals: 1.
	self assert: levelInstance containedLevels first equals: containmentRelation.
	
]

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests >> testMJDPLevelInstanceCreation [
	| levelInstance |

	levelInstance := MJDPLevelInstance new.
	
	self assert: (levelInstance isMemberOf: MJDPLevelInstance).
	self assert: (levelInstance containedLevels isMemberOf: FMMultivalueLink).
	self assert: levelInstance containedLevels isEmpty.
	
]
