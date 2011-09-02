Class {
	#name : #MJFAMIXLogicLayerTests,
	#superclass : #MJFAMIXBusinessLayerTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXLogicLayerTests >> testAnnotation [
	self assert: MJFAMIXLogicLayer annotation == MJFAMIXLogicLayer.
]

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

	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	logicLayer := MJFAMIXLogicLayer new.
	logicLayer populate: mooseModel.
	
	self assert: ((mooseModel allWithType: MJFAMIXLogicLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXLogicLayer) first  = logicLayer).
	self assert: (logicLayer containedClasses size = 0).
]

{ #category : #tests }
MJFAMIXLogicLayerTests >> testName [
	self assert: (MJFAMIXLogicLayer new name = 'Logic Layer')
]
