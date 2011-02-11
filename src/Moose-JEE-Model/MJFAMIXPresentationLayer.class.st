Class {
	#name : #MJFAMIXPresentationLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE-Model'
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
MJFAMIXPresentationLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll: (aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )
]
