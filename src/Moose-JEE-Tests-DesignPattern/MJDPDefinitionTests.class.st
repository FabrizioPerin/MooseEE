Class {
	#name : #MJDPDefinitionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPDefinitionTests >> testAnnotation [
	self assert: MJDPDefinition annotation == MJDPDefinition.
]

{ #category : #'as yet unclassified' }
MJDPDefinitionTests >> testImplementedPattern [
	| pd pia pia2 |

	pd := MJDPDefinition new.
	pia := MJDPPatternInstanceAssoc new.
	pia2 := MJDPPatternInstanceAssoc new.
	
	self assert: (pd isMemberOf: MJDPDefinition).
	self assert: (pd implementedPattern isMemberOf: FMMultivalueLink).
		
	pd implementedPattern: pia.
	
	self assert: (pd implementedPattern isMemberOf: FMMultivalueLink).
	self assert: pd implementedPattern size equals: 1.
	self assert: pd implementedPattern first equals: pia.
	
	pd implementedPattern: pia2.
	
	self assert: (pd implementedPattern isMemberOf: FMMultivalueLink).
	self assert: pd implementedPattern size equals: 1.
	self assert: pd implementedPattern first equals: pia2.
	
	
]

{ #category : #'as yet unclassified' }
MJDPDefinitionTests >> testImplementedPatternSelfUpdate [
	| pd pia |

	pd := MJDPDefinition new.
	pia := MJDPPatternInstanceAssoc new.
	
	self assert: (pd isMemberOf: MJDPDefinition).
	self assert: (pd implementedPattern isMemberOf: FMMultivalueLink).
	self assert: pd implementedPattern size equals: 0.
	
	pia patternDefinition: pd.
	
	self assert: pd implementedPattern first equals: pia.
]

{ #category : #'as yet unclassified' }
MJDPDefinitionTests >> testMJDPDefinitionCreation [
	| dp |
	
	dp := MJDPDefinition new.
	
	self assert: (dp isMemberOf: MJDPDefinition).
	self assert: dp patternName equals: 'Unknown'.
]

{ #category : #'as yet unclassified' }
MJDPDefinitionTests >> testPatternName [
	| dp |
	
	dp := MJDPDefinition new.
	dp patternName: 'Visitor'.
	
	self assert: dp patternName equals: 'Visitor'.
]
