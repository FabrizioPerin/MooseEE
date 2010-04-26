Class {
	#name : #FAMIXPresentationLayer,
	#superclass : #FAMIXLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXPresentationLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll: (aMooseModel allClasses select: [:class | class allMethods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )
]
