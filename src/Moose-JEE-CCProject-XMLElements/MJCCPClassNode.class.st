Class {
	#name : #MJCCPClassNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClassNode >> createElementFrom: aMooseModel [
	| class sources |
	
	class := MJCCPClass new.
	
	class id: self id asNumber.
	class numberOfFragments: self numberOfFragments asNumber.
	class numberOfLines: self numberOfLines asNumber.
	
	(self sources collect: [:each | each createElementFrom: aMooseModel]) do: [:source | source cloneClass: class ].
		
	^class
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

{ #category : #'as yet unclassified' }
MJCCPClassNode >> sources [
	^self elements select: [:each | each name = 'source'].
]
