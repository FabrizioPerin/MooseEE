Class {
	#name : #MJDPLIToLContainmentTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPLIToLContainmentTests >> testAnnotation [
	self assert: MJDPLIToLContainment annotation == MJDPLIToLContainment.
]
