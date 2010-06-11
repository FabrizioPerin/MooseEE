Class {
	#name : #MJFAMIXServiceLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

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
