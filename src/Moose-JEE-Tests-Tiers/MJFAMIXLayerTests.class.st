Class {
	#name : #MJFAMIXLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXLayerTests >> testAnnotation [
	self assert: MJFAMIXLayer annotation == MJFAMIXLayer.
]

{ #category : #tests }
MJFAMIXLayerTests >> testBelongsTo [
	self assert: MJFAMIXLayer new belongsTo = ''.
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
