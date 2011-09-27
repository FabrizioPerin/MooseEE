Class {
	#name : #MJFAMIXServiceLayerTests,
	#superclass : #MJFAMIXBusinessLayerTests,
	#category : #'Moose-JEE-Tests-Tiers'
}

{ #category : #tests }
MJFAMIXServiceLayerTests >> testAnnotation [
	self assert: MJFAMIXServiceLayer annotation == MJFAMIXServiceLayer.
]

{ #category : #testsOnJEEModel }
MJFAMIXServiceLayerTests >> testFAMIXServiceLayerAcceptStrategy [

	| mooseModel serviceLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	serviceLayer := MJFAMIXServiceLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) first  = serviceLayer).
	self assert: serviceLayer containedSessionBeans size = 3.
]

{ #category : #testsOnJEEModel }
MJFAMIXServiceLayerTests >> testFAMIXServiceLayerPopulate [

	| mooseModel serviceLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	serviceLayer := MJFAMIXServiceLayer new.
	serviceLayer populate: mooseModel.
	
	
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) first  = serviceLayer).
	self assert: serviceLayer containedSessionBeans size = 3.
]

{ #category : #tests }
MJFAMIXServiceLayerTests >> testName [
	self assert: (MJFAMIXServiceLayer new name = 'Service Layer')
]
