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
MJDPLevelInstanceTests >> testContainers [
	| levelInstance level |

	levelInstance := MJDPLevelInstance new.
	level := MJDPLevel new.
	
	self assert: levelInstance containers isEmpty.
	
	levelInstance containers: (OrderedCollection with: level).
	
	self assert: (levelInstance containers isMemberOf: FMMultivalueLink).
	self assert: levelInstance containers size equals: 1.
	self assert: levelInstance containers equals: level.
	
]

{ #category : #'as yet unclassified' }
MJDPLevelInstanceTests >> testMKDPLevelInstanceCreation [
	| levelInstance |

	levelInstance := MJDPLevelInstance new.
	
	self assert: (levelInstance isMemberOf: MJDPLevelInstance).
	self assert: (levelInstance containers isMemberOf: FMMultivalueLink).
	self assert: levelInstance containers isEmpty.
	
]
