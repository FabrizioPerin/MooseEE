Class {
	#name : #MJFAMIXDataLayerTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

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
