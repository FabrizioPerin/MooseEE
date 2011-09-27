Class {
	#name : #MJLayeringStrategy,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJLayeringStrategy class >> on: aMooseModel [
	
	^self new initialize: aMooseModel.
]

{ #category : #'as yet unclassified' }
MJLayeringStrategy >> initialize: aMooseModel [

	model := aMooseModel.
	
	^self
]

{ #category : #'as yet unclassified' }
MJLayeringStrategy >> instanciateLayers [
	
	self subclassResponsibility 
]
