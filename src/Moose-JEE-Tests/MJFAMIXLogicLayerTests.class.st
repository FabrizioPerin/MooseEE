Class {
	#name : #MJFAMIXLogicLayerTests,
	#superclass : #MJFAMIXBusinessLayerTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #testsOnJEEModel }
MJFAMIXLogicLayerTests >> testFAMIXLogicLayerAcceptStrategy [

	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	logicLayer := MJFAMIXLogicLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: ((mooseModel allWithType: MJFAMIXLogicLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXLogicLayer) first  = logicLayer).
	self assert: logicLayer containedClasses size = 0.
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
