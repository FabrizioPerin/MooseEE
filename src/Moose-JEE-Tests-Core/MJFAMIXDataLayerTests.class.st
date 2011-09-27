Class {
	#name : #MJFAMIXDataLayerTests,
	#superclass : #MJFAMIXLayerTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXDataLayerTests >> testAnnotation [
	self assert: MJFAMIXDataLayer annotation == MJFAMIXDataLayer.
]

{ #category : #testsOnJEEModel }
MJFAMIXDataLayerTests >> testFAMIXDataLayerAcceptStrategy [

	| mooseModel dataLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	dataLayer := MJFAMIXDataLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
		
	self assert: ((mooseModel allWithType: MJFAMIXDataLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXDataLayer) first  = dataLayer).
	self assert: dataLayer containedClasses size = 2.
]

{ #category : #testsOnJEEModel }
MJFAMIXDataLayerTests >> testFAMIXDataLayerPopulate [

	| mooseModel dataLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	dataLayer := MJFAMIXDataLayer new.
	dataLayer populate: mooseModel.
	
	
	self assert: ((mooseModel allWithType: MJFAMIXDataLayer) size = 1).
	self assert: ((mooseModel allWithType: MJFAMIXDataLayer) first  = dataLayer).
	self assert: dataLayer containedClasses size = 2.
]

{ #category : #tests }
MJFAMIXDataLayerTests >> testName [
	self assert: (MJFAMIXDataLayer new name = 'Data Layer')
]
