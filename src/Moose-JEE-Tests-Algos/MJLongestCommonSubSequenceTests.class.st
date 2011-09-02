Class {
	#name : #MJLongestCommonSubSequenceTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Algos'
}

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testASequence [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).
	
	self assert: lcs aSequence equals: 'tggctgcgaatg'.

]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testAnotherSequence [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs anotherSequence equals: 'aacggcgcgaatgasdr'.

]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testDirectionsMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs directionMatrix isNil.

]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testInitializeDirectionsMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs initializeDirectionsMatrix.
	
	self assert: (lcs directionMatrix isMemberOf: MalArrayMatrix).
	self assert: lcs directionMatrix rowSize equals: 'tggctgcgaatg' size.
	self assert: lcs directionMatrix columnSize equals: 'aacggcgcgaatgasdr' size.
	
]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testInitializeValuesMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs initializeValuesMatrix. 
	
	self assert: (lcs valuesMatrix isMemberOf: MalArrayMatrix).
	self assert: lcs valuesMatrix rowSize equals: 'tggctgcgaatg' size.
	self assert: lcs valuesMatrix columnSize equals: 'aacggcgcgaatgasdr' size.
	
	(1 to: lcs aSequence size) anySatisfy: [:index | (lcs valuesMatrix at: index and: 1) = 0 ].	
	(1 to: lcs anotherSequence size) do: [:index | (lcs valuesMatrix at: 1 and: index) = 0 ].
	
]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testMJLongestCommonSubSequenceCreation [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

]

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequenceTests >> testValuesMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs valuesMatrix isNil.
]
