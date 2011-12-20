Class {
	#name : #MJDPPatternInstanceAssocTest,
	#superclass : #TestCase,
	#instVars : [
		'patternDefinition',
		'levelInstance'
	],
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testFrom [
	| pd pia pd2 |

	pd := MJDPDefinition new.
	pd2 := MJDPDefinition new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia patternDefinition isNil.

	pia patternDefinition: pd. 
	
	self assert: (pia from isMemberOf: MJDPDefinition).
	self assert: pia from equals: pd.
	
	pia patternDefinition: pd2. 
	
	self assert: (pia from isMemberOf: MJDPDefinition).
	self assert: pia from equals: pd2.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testLevelInstance [
	| lI pia lI2 |

	lI := MJDPLevelInstance new.
	lI2 := MJDPLevelInstance new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia levelInstance isNil.

	pia levelInstance: lI. 
	
	self assert: (pia levelInstance isMemberOf: MJDPLevelInstance).
	self assert: pia levelInstance equals: lI.
	
	pia levelInstance: lI2. 
	
	self assert: (pia levelInstance isMemberOf: MJDPLevelInstance).
	self assert: pia levelInstance equals: lI2.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testLevelInstanceSelfUpdate [
	| lI pia lI2 |

	lI := MJDPLevelInstance new.
	lI2 := MJDPLevelInstance new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia levelInstance isNil.

	lI patternDefinition: pia. 
	
	self assert: (pia levelInstance isMemberOf: MJDPLevelInstance).
	self assert: pia levelInstance equals: lI.
	
	 lI2 patternDefinition: pia. 
	
	self assert: (pia levelInstance isMemberOf: MJDPLevelInstance).
	self assert: pia levelInstance equals: lI2.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testMJDPPatternInstanceAssocCreation [
	| assoc |

	assoc := MJDPPatternInstanceAssoc new.
	
	self assert: (assoc isMemberOf: MJDPPatternInstanceAssoc).
	self assert: assoc from isNil.
	self assert: assoc to isNil.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testPatternDefinition [
	| pd pia pd2 |

	pd := MJDPDefinition new.
	pd2 := MJDPDefinition new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia patternDefinition isNil.

	pia patternDefinition: pd. 
	
	self assert: (pia patternDefinition isMemberOf: MJDPDefinition).
	self assert: pia patternDefinition equals: pd.
	
	pia patternDefinition: pd2. 
	
	self assert: (pia patternDefinition isMemberOf: MJDPDefinition).
	self assert: pia patternDefinition equals: pd2.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testPatternDefinitionSelfUpdate [
	| pd pia pd2 |

	pd := MJDPDefinition new.
	pd2 := MJDPDefinition new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia patternDefinition isNil.

	pd implementedPattern: pia. 
	
	self assert: (pia patternDefinition isMemberOf: MJDPDefinition).
	self assert: pia patternDefinition equals: pd.
	
	pd2 implementedPattern: pia. 
	
	self assert: (pia patternDefinition isMemberOf: MJDPDefinition).
	self assert: pia patternDefinition equals: pd2.
]

{ #category : #'as yet unclassified' }
MJDPPatternInstanceAssocTest >> testTo [
	| lI pia lI2 |

	lI := MJDPLevelInstance new.
	lI2 := MJDPLevelInstance new.
	pia := MJDPPatternInstanceAssoc new.

	self assert: pia levelInstance isNil.

	pia levelInstance: lI. 
	
	self assert: (pia to isMemberOf: MJDPLevelInstance).
	self assert: pia to equals: lI.
	
	 pia levelInstance: lI2. 
	
	self assert: (pia to isMemberOf: MJDPLevelInstance).
	self assert: pia to equals: lI2.
]
