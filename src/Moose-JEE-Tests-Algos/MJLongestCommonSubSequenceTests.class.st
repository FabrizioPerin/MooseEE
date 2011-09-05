Class {
	#name : #MJLongestCommonSubSequenceTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Algos'
}

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testComputelcsLenght [
	| lcs res |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	res := lcs computelcsLenght.

	self assert: res equals: lcs result.
	self assert: res  equals:  'ggcgcgaatg'.
	

]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testDirectionsMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs directionMatrix isNil.

]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testFirstSequence [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).
	
	self assert: lcs firstSequence equals: 'tggctgcgaatg'.

]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testInitializeDirectionsMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs initializeDirectionsMatrix.
	
	self assert: (lcs directionMatrix isMemberOf: MalArrayMatrix).
	self assert: lcs directionMatrix rowSize equals: ('tggctgcgaatg' size + 1).
	self assert: lcs directionMatrix columnSize equals: ('aacggcgcgaatgasdr' size + 1).
	
]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testInitializeValuesMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs initializeValuesMatrix. 
	
	self assert: (lcs valuesMatrix isMemberOf: MalArrayMatrix).
	self assert: lcs valuesMatrix rowSize equals: ('tggctgcgaatg' size + 1).
	self assert: lcs valuesMatrix columnSize equals: ('aacggcgcgaatgasdr' size + 1).
	
	(1 to: lcs valuesMatrix rowSize) allSatisfy: [:index | (lcs valuesMatrix at: index and: 1) = 0 ].	
	(1 to: lcs valuesMatrix columnSize) allSatisfy: [:index | (lcs valuesMatrix at: 1 and: index) = 0 ].
	
]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testLcsLength [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs lcsLength.
	
	self assert: (lcs valuesMatrix at: lcs valuesMatrix rowSize and: lcs valuesMatrix columnSize) equals: 10.
	
	lcs := MJLongestCommonSubSequence of: 'abcbdab' and: 'bdcaba'.
	
	lcs lcsLength.
	
	self assert: (lcs valuesMatrix at: lcs valuesMatrix rowSize and: lcs valuesMatrix columnSize) equals: 4.
	
	
]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testMJLongestCommonSubSequenceCreation [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testPrintLCSRecursivlyOnPositionAnd [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs lcsLength.

	self assert: ((lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) isMemberOf: ByteString).
	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) size equals: 10.
	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) equals:  'ggcgcgaatg'.
	
	
	lcs := MJLongestCommonSubSequence of: 'abcbdab' and: 'bdcaba'.
	
	lcs lcsLength.
	
	self assert: ((lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) isMemberOf: ByteString).
	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) size equals: 4.
	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) equals:  'bcba'.
]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testResults [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	lcs lcsLength.

	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) equals: lcs result.
	self assert: lcs result equals: 'ggcgcgaatg'.

	
	lcs := MJLongestCommonSubSequence of: 'abcbdab' and: 'bdcaba'.
	
	lcs lcsLength.
	
	self assert: (lcs printLCSRecursivlyOnPosition: lcs firstSequence size and: lcs secondSequence size) equals: lcs result.
	self assert: lcs result equals: 'bcba'.

	
]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testSecondSequence [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs secondSequence equals: 'aacggcgcgaatgasdr'.

]

{ #category : #tests }
MJLongestCommonSubSequenceTests >> testValuesMatrix [
	| lcs |
	
	lcs := MJLongestCommonSubSequence of: 'tggctgcgaatg' and: 'aacggcgcgaatgasdr'.
	
	self assert: (lcs isMemberOf: MJLongestCommonSubSequence).

	self assert: lcs valuesMatrix isNil.
]
