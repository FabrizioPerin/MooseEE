Class {
	#name : #MJFAMIXLogicLayerTests,
	#superclass : #MJFAMIXBusinessLayerTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #testsOnJEEModel }
MJFAMIXLogicLayerTests >> testFAMIXLogicLayerAcceptStrategy [

	| mooseModel serviceLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	serviceLayer := MJFAMIXLogicLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	"self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) first  = serviceLayer).
	self assert: serviceLayer containedSessionBeans size = 3."
]

{ #category : #testsOnJEEModel }
MJFAMIXLogicLayerTests >> testFAMIXLogicLayerPopulate [

	| mooseModel serviceLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	serviceLayer := MJFAMIXServiceLayer new.
	serviceLayer populate: mooseModel.
	
	
	"self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXServiceLayer) first  = serviceLayer).
	self assert: serviceLayer containedSessionBeans size = 3."
]
