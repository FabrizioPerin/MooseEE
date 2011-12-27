Class {
	#name : #MJCCPClassNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClassNode >> createElementFrom: aMooseModel [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
MJCCPClassNode >> id [
	^self attributes at: 'id' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPClassNode >> numberOfFragments [
	^self attributes at: 'nfragments' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPClassNode >> numberOfLines [
	^self attributes at: 'nlines' ifAbsent: [nil].
]
