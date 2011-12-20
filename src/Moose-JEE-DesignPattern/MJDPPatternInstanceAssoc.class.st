Class {
	#name : #MJDPPatternInstanceAssoc,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'patternDefinition',
		'levelInstance'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> from [
	^self patternDefinition
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> initialize [
	super initialize.
	
	patternDefinition := nil.
	levelInstance := nil.
	
	^self 
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> levelInstance [
	<MSEProperty: #levelInstance type: #MJDPLevelInstance opposite: #implementedPattern>
	<MSEComment: 'Level Instance containing a Level'>
	
	^levelInstance 
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> levelInstance: aLevelInstance [

	levelInstance := FMMultivalueLink 
								on: self
								update: #patternDefinition
								from: self levelInstance  
								to: aLevelInstance
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> patternDefinition [
	<MSEProperty: #patternDefinition type: #MJDPDefinition opposite: #implementedPattern>
	<MSEComment: 'Level contained into a Level Instance'>
	
	^patternDefinition
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> patternDefinition: aDPDefinition [

	patternDefinition := FMMultivalueLink 
						on: self
						update: #implementedPattern
						from: self patternDefinition 
						to: aDPDefinition
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (DP Instance)'
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssoc >> to [
	^self levelInstance
]
