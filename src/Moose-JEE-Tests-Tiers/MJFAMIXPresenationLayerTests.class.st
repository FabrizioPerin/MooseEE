Class {
	#name : #MJFAMIXPresenationLayerTests,
	#superclass : #MJFAMIXBusinessLayerTests,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXPresenationLayerTests >> testAnnotation [
	self assert: MJFAMIXPresentationLayer annotation == MJFAMIXPresentationLayer.
]

{ #category : #testsOnJEEModel }
MJFAMIXPresenationLayerTests >> testFAMIXPresentationLayerAcceptStrategy [

	| mooseModel presentationLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	presentationLayer := MJFAMIXPresentationLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: ((mooseModel allWithType: MJFAMIXPresentationLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXPresentationLayer) first  = presentationLayer).
	self assert: presentationLayer containedElements size = 0.
]

{ #category : #testsOnJEEModel }
MJFAMIXPresenationLayerTests >> testFAMIXPresentationLayerPopulate [

	| mooseModel presentationLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	presentationLayer := MJFAMIXPresentationLayer new.
	presentationLayer populate: mooseModel.
	
	self assert: ((mooseModel allWithType: MJFAMIXPresentationLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXPresentationLayer) first  = presentationLayer).
	self assert: (presentationLayer containedElements size = 0).
]

{ #category : #tests }
MJFAMIXPresenationLayerTests >> testName [
	self assert: (MJFAMIXPresentationLayer new name = 'Presentation Layer')
]
