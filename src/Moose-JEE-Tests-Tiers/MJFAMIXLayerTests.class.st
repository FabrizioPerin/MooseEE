Class {
	#name : #MJFAMIXLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXLayerTests >> testAddContainedElements [
	| presentation el1 el2 el3 |

	presentation := MJFAMIXPresentationLayer new.

	self assert: (presentation containedElements isMemberOf: FMMultivalueLink).
	self assert: presentation containedElements size equals: 0.
	
	el1 := FAMIXEntity new.
	el2 := FAMIXEntity new.
	el3 := FAMIXEntity new.
	
	presentation addContainedElement: el1.
	presentation addContainedElement: el2.
	presentation addContainedElement: el3.
	
	self assert: presentation containedElements size equals: 3.
	
	self assert: el1 containerLayer equals: presentation.
	self assert: el2 containerLayer equals: presentation.
	self assert: el3 containerLayer equals: presentation.
	
	
]

{ #category : #tests }
MJFAMIXLayerTests >> testAnnotation [
	self assert: MJFAMIXLayer annotation == MJFAMIXLayer.
]

{ #category : #tests }
MJFAMIXLayerTests >> testBelongsTo [
	self assert: MJFAMIXLayer new belongsTo = ''.
]

{ #category : #tests }
MJFAMIXLayerTests >> testContainedElements [
	| presentation el1 |

	presentation := MJFAMIXPresentationLayer new.

	self assert: (presentation containedElements isMemberOf: FMMultivalueLink).
	self assert: presentation containedElements size equals: 0.
	
	el1 := FAMIXEntity new.
		
	presentation addContainedElement: el1.
	
	
	self assert: presentation containedElements size equals: 1.

]

{ #category : #tests }
MJFAMIXLayerTests >> testFileOutContainedClasses [ 
	
	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	logicLayer := MJFAMIXLogicLayer new.
	logicLayer populate: mooseModel.

	self deny: (FileSystem workingDirectory fileNames includes: 'Logic.out').
	
	MJFAMIXLogicLayer new fileOutContainedClasses.
	
	self assert: (FileSystem workingDirectory fileNames includes: 'Logic.out').
	
	(FileSystem workingDirectory / 'Logic.out') asFileReference delete.
	self deny: (FileSystem workingDirectory fileNames includes: 'Logic.out').
]

{ #category : #tests }
MJFAMIXLayerTests >> testLowerLevel [
	| logicLayer presentation |

	logicLayer := MJFAMIXLogicLayer new.
	presentation := MJFAMIXPresentationLayer new.

	self assert: logicLayer lowerLevel equals: nil.
	self assert: logicLayer upperLevel equals: nil.
	self assert: presentation lowerLevel equals: nil.
	self assert: presentation upperLevel equals: nil.
	
	presentation lowerLevel: logicLayer.
	
	self assert: presentation lowerLevel equals: logicLayer.
	self assert: logicLayer upperLevel equals: presentation. 
]

{ #category : #tests }
MJFAMIXLayerTests >> testUpperLevel [
	| logicLayer presentation |

	logicLayer := MJFAMIXLogicLayer new.
	presentation := MJFAMIXPresentationLayer new.

	self assert: logicLayer lowerLevel equals: nil.
	self assert: logicLayer upperLevel equals: nil.
	self assert: presentation lowerLevel equals: nil.
	self assert: presentation upperLevel equals: nil.
	
	logicLayer upperLevel: presentation.
	
	self assert: presentation lowerLevel equals: logicLayer.
	self assert: logicLayer upperLevel equals: presentation. 
]
