Class {
	#name : #MJFAMIXLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXLayerTests >> testAnnotation [
	self assert: MJFAMIXLayer annotation == MJFAMIXLayer.
]

{ #category : #tests }
MJFAMIXLayerTests >> testFileOutContainedClasses [ 
	
	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	logicLayer := MJFAMIXLogicLayer new.
	logicLayer populate: mooseModel.

	self deny: (FileDirectory default fileNames includes: 'Logic.out').
	
	MJFAMIXLogicLayer new fileOutContainedClasses.
	
	self assert: (FileDirectory default fileNames includes: 'Logic.out').
	
	FileDirectory default deleteFileNamed: 'Logic.out'.
	self deny: (FileDirectory default fileNames includes: 'Logic.out').
]
