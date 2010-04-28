Class {
	#name : #MJFAMIXPresentationLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MJFAMIXPresentationLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll: (aMooseModel allClasses select: [:class | class allMethods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )
]
