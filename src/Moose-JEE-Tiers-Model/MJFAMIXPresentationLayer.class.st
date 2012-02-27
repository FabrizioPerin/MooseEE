Class {
	#name : #MJFAMIXPresentationLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer class >> annotation [
	<MSEClass: #MJFAMIXPresentationLayer super: #MJFAMIXLayer>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populatePresentationLayer: self  
	
]

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer >> name [
	^'Presentation Layer'
]

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer >> selectClassesFrom: aMooseModel [

	containedElements addAll: (aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )
]
