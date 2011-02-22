Class {
	#name : #MJInstanciateEmptyTestModel,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJInstanciateEmptyTestModel >> execute [
	^(MooseModel new name: 'test') install
]

{ #category : #'as yet unclassified' }
MJInstanciateEmptyTestModel >> label [
	^ 'Instantiate empty test model'
]
