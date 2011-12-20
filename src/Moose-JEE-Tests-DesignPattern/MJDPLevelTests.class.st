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
MJDPLevelTests >> testAddContainedLevelInstances [
	| level containmentRelation |

	level :=  MJDPLevel new.
	containmentRelation := MJDPLIToLContainment new.
	
	self assert: level containerLevelInstances isEmpty.
	
	level addContainerLevelInstance: containmentRelation.
	
	self assert: (level containerLevelInstances isMemberOf: FMMultivalueLink).
	self assert: level containerLevelInstances size equals: 1.
	self assert: level containerLevelInstances first equals: containmentRelation.
	
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testAnnotation [
	self assert: MJDPLevel annotation == MJDPLevel.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testChildLevels [
	| level child1 child2 |

	level := MJDPLevel new.
	child1 := MJDPLevel new.
	child2 := MJDPLevel new.
	
	self assert: (level isMemberOf: MJDPLevel).

	self assert: (level childLevels isMemberOf: FMMultivalueLink).
	self assert: level childLevels isEmpty.
	
	level childLevels: (OrderedCollection with: child1 with: child2).
	
	self assert: (level childLevels isMemberOf: FMMultivalueLink).
	self assert: level childLevels size equals: 2.
	self assert: level childLevels first equals: child1.
	self assert: level childLevels second equals: child2.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testContainedLevelInstances [
	| level containmentRelation |

	level :=  MJDPLevel new.
	containmentRelation := MJDPLIToLContainment new.
	
	self assert: level containerLevelInstances isEmpty.
	
	level containerLevelInstances: (OrderedCollection with: containmentRelation).
	
	self assert: (level containerLevelInstances isMemberOf: FMMultivalueLink).
	self assert: level containerLevelInstances size equals: 1.
	self assert: level containerLevelInstances first equals: containmentRelation.
	
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testIsRoot [
	| level child |

	level := MJDPLevel new.
	child := MJDPLevel new.

	self assert: child isRoot.
	
	child parentLevel: level.
	
	self deny: child isRoot.
	
	child parentLevel: nil.
	
	self assert: child isRoot. 
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testMJDPLevelCreation [
	| level |

	level := MJDPLevel new.
	
	self assert: (level isMemberOf: MJDPLevel).
	
	self assert: (level containerLevelInstances isMemberOf: FMMultivalueLink).
	self assert: level containerLevelInstances isEmpty.
	
	self assert: (level childLevels isMemberOf: FMMultivalueLink).
	self assert: level childLevels isEmpty.
	
	self assert: level parentLevel isNil.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testParentLevel [
	| level child |

	level := MJDPLevel new.
	child := MJDPLevel new.
	
	self assert: (level isMemberOf: MJDPLevel).
	self assert: level parentLevel isNil.
	
	child parentLevel: level.
	
	self assert: child parentLevel equals: level.
]

{ #category : #'as yet unclassified' }
MJDPLevelTests >> testParentLevelSelfUpdate [
	| level child1 child2 |

	level := MJDPLevel new.
	child1 := MJDPLevel new.
	child2 := MJDPLevel new.
	
	self assert: (level isMemberOf: MJDPLevel).
	level childLevels: (OrderedCollection with: child1 with: child2).
	
	self assert: child1 parentLevel equals: level.
	self assert: child2 parentLevel equals: level.
]
