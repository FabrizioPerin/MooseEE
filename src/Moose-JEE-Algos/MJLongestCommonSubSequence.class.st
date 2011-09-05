Class {
	#name : #MJLongestCommonSubSequence,
	#superclass : #Object,
	#instVars : [
		'valuesMatrix',
		'directionsMatrix',
		'result',
		'firstSequence',
		'secondSequence'
	],
	#category : #'Moose-JEE-Algos'
}

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequence class >> of: aSequence and: anotherSequence [

	^(self new
		firstSequence: aSequence;
		secondSequence: anotherSequence)
		
]

{ #category : #run }
MJLongestCommonSubSequence >> computelcsLenght [
			
		self lcsLength.
		self printLCSRecursivlyOnPosition: firstSequence size and: secondSequence size.
		
		^result 
]

{ #category : #accessing }
MJLongestCommonSubSequence >> directionMatrix [
	^ directionsMatrix
]

{ #category : #accessing }
MJLongestCommonSubSequence >> firstSequence [
	^ firstSequence
]

{ #category : #initialize }
MJLongestCommonSubSequence >> firstSequence: anObject [
	firstSequence := anObject
]

{ #category : #initialize }
MJLongestCommonSubSequence >> initializeDirectionsMatrix [

	directionsMatrix := MalArrayMatrix new: (firstSequence size + 1) @ (secondSequence size + 1).
]

{ #category : #initialize }
MJLongestCommonSubSequence >> initializeValuesMatrix [

	valuesMatrix := MalArrayMatrix new: (firstSequence size + 1) @ (secondSequence size + 1).

	(2 to: valuesMatrix rowSize) do: [:index | valuesMatrix at: index and: 1 put: 0 ].	
	(1 to: valuesMatrix columnSize) do: [:index | valuesMatrix at: 1 and: index put: 0 ].

]

{ #category : #algorithms }
MJLongestCommonSubSequence >> lcsLength [
	| xLength yLength |

	xLength := firstSequence size.
	yLength := secondSequence size.
	
	self initializeValuesMatrix.
	self initializeDirectionsMatrix.
	
	"Values and directions matrixes start from 1 and their size is firstSequence + 1 X secondSequence + 1. So we have to move the rowIndex and the column index ahead of 1to match the correct position because "
	(1 to: xLength) do: [:rowIndex |
		(1 to: yLength) do: [:colIndex |
			((firstSequence at: rowIndex) = (secondSequence at: colIndex)) 
				ifTrue: [
					valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: ((valuesMatrix at: (rowIndex + 1 - 1) and: (colIndex +1 - 1)) + 1).
					directionsMatrix at: (rowIndex + 1) and: (colIndex + 1) put: #d.]
				ifFalse: [
					((valuesMatrix at: (rowIndex + 1 - 1) and: (colIndex + 1)) >= (valuesMatrix at: (rowIndex + 1) and: (colIndex +1 - 1)))
						ifTrue: [
							valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: (valuesMatrix at: (rowIndex + 1 - 1) and: (colIndex + 1)).
							directionsMatrix at: (rowIndex + 1) and: (colIndex + 1) put: #u.]
						ifFalse: [
							valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: (valuesMatrix at: (rowIndex + 1) and: (colIndex + 1 - 1)).
							directionsMatrix at: (rowIndex + 1) and: (colIndex + 1) put: #l.] ] ] ] 
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> printLCSRecursivlyOnPosition: xIndex and: yIndex [

	(xIndex = 0 or: [yIndex = 0]) ifTrue: [
		result := ''.
		^result].
	
	((directionsMatrix at:  (xIndex + 1) and:  (yIndex + 1)) = #d)
		ifTrue: [
			self printLCSRecursivlyOnPosition: (xIndex - 1) and: (yIndex - 1).
			result := result , (firstSequence at: xIndex) asString.]
		ifFalse: [
			((directionsMatrix at: (xIndex + 1) and: (yIndex + 1)) = #u)
				ifTrue: [self printLCSRecursivlyOnPosition: (xIndex - 1)  and: yIndex] 
				ifFalse: [self printLCSRecursivlyOnPosition: xIndex  and: (yIndex - 1)] ].
	
	^result 
]

{ #category : #accessing }
MJLongestCommonSubSequence >> result [
	^ result
]

{ #category : #accessing }
MJLongestCommonSubSequence >> secondSequence [
	^ secondSequence
]

{ #category : #initialize }
MJLongestCommonSubSequence >> secondSequence: anObject [
	secondSequence := anObject
]

{ #category : #accessing }
MJLongestCommonSubSequence >> valuesMatrix [
	^ valuesMatrix
]
