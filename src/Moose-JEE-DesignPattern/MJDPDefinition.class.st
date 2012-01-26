Class {
	#name : #MJDPDefinition,
	#superclass : #MJDPAssociation,
	#instVars : [
		'patternName',
		'implementedPattern'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPDefinition class >> annotation [
	<MSEClass: #MJDPDefinition super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #accessing }
MJDPDefinition >> implementedPattern [
	<MSEProperty: #implementedPattern type: #MJDPPatternInstanceAssoc opposite: #childLevels>
	<MSEComment: 'Association to the level instance that is root for this pattern'>
	
	^implementedPattern

]

{ #category : #accessing }
MJDPDefinition >> implementedPattern: aMJDPPatternInstanceAssoc [
	
	 self implementedPattern value: (OrderedCollection with: aMJDPPatternInstanceAssoc).
]

{ #category : #accessing }
MJDPDefinition >> initialize [
	super initialize.
	
	patternName := 'Unknown'.
	implementedPattern :=  FMMultivalueLink on: self opposite: #patternDefinition:.
	
	^self
	
]

{ #category : #accessing }
MJDPDefinition >> patternName [
	^ patternName
]

{ #category : #accessing }
MJDPDefinition >> patternName: aString [
	patternName := aString
]
