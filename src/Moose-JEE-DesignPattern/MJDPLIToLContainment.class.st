Class {
	#name : #MJDPLIToLContainment,
	#superclass : #MJDPAssociation,
	#instVars : [
		'level',
		'levelInstance'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> from [
	^self levelInstance
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> initialize [
	super initialize.
	
	level := nil.
	levelInstance := nil.
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> level [
	<MSEProperty: #level type: #MJDPLevel opposite: #containerLevelInstances>
	<MSEComment: 'Level contained into a Level Instance'>
	
	^level
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> level: aLevel [

		level := FMMultivalueLink 
						on: self
						update: #containerLevelInstances
						from: self level  
						to: aLevel
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> levelInstance [
	<MSEProperty: #levelInstance type: #MJDPLevelInstance opposite: #containedLevels>
	<MSEComment: 'Level Instance containing a Level'>
	
	^levelInstance
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> levelInstance: aLevelInstance [

	levelInstance := FMMultivalueLink 
								on: self
								update: #containedLevels
								from: self levelInstance  
								to: aLevelInstance
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (Level Containment)'
]

{ #category : #'as yet unclassified' }
MJDPLIToLContainment >> to [
	^self level
]
