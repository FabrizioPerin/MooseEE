Class {
	#name : #MJCCPAbstractReportNode,
	#superclass : #XMLElement,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPAbstractReportNode >> createElementFrom: aMooseModel [
	self subclassResponsibility.
]
