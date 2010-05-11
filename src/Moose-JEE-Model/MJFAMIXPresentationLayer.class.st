Class {
	#name : #MJFAMIXPresentationLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll: (aMooseModel allClasses select: [:class | class methods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )
]
