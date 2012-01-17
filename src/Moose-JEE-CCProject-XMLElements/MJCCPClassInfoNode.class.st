Class {
	#name : #MJCCPClassInfoNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClassInfoNode >> createElementFrom: aMooseModel [
	| classinfo |
	
	classinfo := MJCCPClassinfo new.
	
	classinfo
		numberOfClones:
			(self numberOfClones first isDigit
				ifTrue: [ self numberOfClones asNumber ]
				ifFalse: [ self numberOfClones ]).
	classinfo numberOfClasses: self numberOfClasses asNumber.
	classinfo numberOfPairs: 
		(self numberOfPairs first isDigit
				ifTrue: [ self numberOfPairs asNumber ]
				ifFalse: [ self numberOfPairs ]).
	classinfo numberOfFragments:
		(self numberOfFragments first isDigit
				ifTrue: [ self numberOfFragments asNumber ]
				ifFalse: [ self numberOfFragments ]).
				
	^ classinfo
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNode >> numberOfClasses [

	^self attributes at: 'nclasses' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNode >> numberOfClones [

	^self attributes at: 'nclones' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNode >> numberOfFragments [

	^self attributes at: 'nfragments' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNode >> numberOfPairs [

	^self attributes at: 'npairs' ifAbsent: [nil].
]
