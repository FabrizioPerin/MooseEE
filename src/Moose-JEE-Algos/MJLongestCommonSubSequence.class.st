Class {
	#name : #MJLongestCommonSubSequence,
	#superclass : #Object,
	#instVars : [
		'valuesMatrix',
		'directionsMatrix',
		'aSequence',
		'anotherSequence',
		'result'
	],
	#category : #'Moose-JEE-Algos'
}

{ #category : #'as yet unclassified' }
MJLongestCommonSubSequence class >> of: aSequenceX and: anotherSequenceY [

	^(self new
		aSequence: aSequenceX;
		anotherSequence: anotherSequenceY)
		
]

{ #category : #accessing }
MJLongestCommonSubSequence >> aSequence [
	^ aSequence
]

{ #category : #initialize }
MJLongestCommonSubSequence >> aSequence: anObject [
	aSequence := anObject
]

{ #category : #accessing }
MJLongestCommonSubSequence >> anotherSequence [
	^ anotherSequence
]

{ #category : #initialize }
MJLongestCommonSubSequence >> anotherSequence: anObject [
	anotherSequence := anObject
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> computelcsLenght [
			
		self lcsLenght.
		self printLCSRecursivlyOnPosition: aSequence size and: anotherSequence size.
		
		^result 
]

{ #category : #accessing }
MJLongestCommonSubSequence >> directionMatrix [
	^ directionsMatrix
]

{ #category : #initialize }
MJLongestCommonSubSequence >> initializeDirectionsMatrix [

	directionsMatrix := MalArrayMatrix new: aSequence size @ anotherSequence size.
]

{ #category : #initialize }
MJLongestCommonSubSequence >> initializeValuesMatrix [

	valuesMatrix := MalArrayMatrix new: aSequence size @ anotherSequence size.

	(1 to: aSequence size) do: [:index | valuesMatrix at: index and: 1 put: 0 ].	
	(1 to: anotherSequence size) do: [:index | valuesMatrix at: 1 and: index put: 0 ].

]

{ #category : #algorithms }
MJLongestCommonSubSequence >> lcsLenght [
	| xLength yLength |

	xLength := aSequence size.
	yLength := anotherSequence size.
	
	self initializeValuesMatrixWith: xLength and: yLength.
	self initializeDirectionsMatrixWith: xLength and: yLength.
	
	(1 to: xLength) do: [:rowIndex |
		(1 to: yLength) do: [:colIndex |
			((aSequence at: rowIndex) = (anotherSequence at: colIndex)) 
				ifTrue: [
					valuesMatrix at: rowIndex and: colIndex put: ((valuesMatrix at: (rowIndex - 1) and: (colIndex - 1)) + 1).
					directionsMatrix at: rowIndex and: colIndex put: #d.]
				ifFalse: [
					((valuesMatrix at: (rowIndex - 1) and: colIndex) >= (valuesMatrix at: rowIndex and: (colIndex - 1)))
						ifTrue: [
							valuesMatrix at: rowIndex and: colIndex put: (valuesMatrix at: (rowIndex - 1) and: colIndex).
							directionsMatrix at: rowIndex and: colIndex put: #u.]
						ifFalse: [
							valuesMatrix at: rowIndex and: colIndex put: (valuesMatrix at: rowIndex and: (colIndex - 1)).
							directionsMatrix at: rowIndex and: colIndex put: #l.] ] ] ] 
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> printLCSRecursivlyOnPosition: xIndex and: yIndex [

	(xIndex = 0 or: [yIndex = 0]) ifTrue: [result := ''].
	
	((directionsMatrix at: xIndex and: yIndex) = #d)
		ifTrue: [
			self printLCSRecursivlyOnPosition: (xIndex - 1) and: (yIndex - 1).
			result := result , (aSequence at: xIndex) asString]
		ifFalse: [
			((directionsMatrix at: xIndex and: yIndex) = #u)
				ifTrue: [self printLCSRecursivlyOnPosition: (xIndex - 1)  and: yIndex] 
				ifFalse: [self printLCSRecursivlyOnPosition: xIndex  and: (yIndex - 1)] ].
]

{ #category : #accessing }
MJLongestCommonSubSequence >> result [
	^ result
]

{ #category : #accessing }
MJLongestCommonSubSequence >> valuesMatrix [
	^ valuesMatrix
]
