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
		secondSequence: anotherSequence;
		result: nil)
		
]

{ #category : #run }
MJLongestCommonSubSequence >> computelcsLenght [
			
		self lcsLength.
		^self printLCSRecursivlyStartingFrom: firstSequence size to: secondSequence size.

]

{ #category : #accessing }
MJLongestCommonSubSequence >> directionMatrix [
	^ directionsMatrix
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> exportCVSEntryHeaderOn: aStream [
	aStream nextPutAll: ('First Sequence' , ';' , 'Second Sequence' , ';' , 'LCS size' , ';' , 'LCS' , String cr).
	^aStream
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> exportResultAsCVSEntryOn: aStream [
	
	aStream nextPutAll: (firstSequence , ';' , secondSequence , ';' , (self printLCSRecursivlyStartingFrom: firstSequence size to: secondSequence size) size asString , ';' , result , String cr).
	^aStream
]

{ #category : #algorithms }
MJLongestCommonSubSequence >> exportResultAsCVSEntryWithHeaderOn: aStream [
	self exportCVSEntryHeaderOn: aStream.
	self exportResultAsCVSEntryOn: aStream.
	^aStream
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
MJLongestCommonSubSequence >> printLCSRecursivlyStartingFrom: anIndex to: anotherIndex [

	(anIndex = 0 or: [anotherIndex = 0]) ifTrue: [
		result := ''.
		^result].
	
	((directionsMatrix at:  (anIndex + 1) and:  (anotherIndex + 1)) = #d)
		ifTrue: [
			self printLCSRecursivlyStartingFrom: (anIndex - 1) to: (anotherIndex - 1).
			result := result , (firstSequence at: anIndex) asString.]
		ifFalse: [
			((directionsMatrix at: (anIndex + 1) and: (anotherIndex + 1)) = #u)
				ifTrue: [self printLCSRecursivlyStartingFrom: (anIndex - 1)  to: anotherIndex] 
				ifFalse: [self printLCSRecursivlyStartingFrom: anIndex  to: (anotherIndex - 1)] ].
	
	^result 
]

{ #category : #accessing }
MJLongestCommonSubSequence >> result [
	result isNil ifTrue: [self computelcsLenght].
	^ result
]

{ #category : #initialize }
MJLongestCommonSubSequence >> result: aStringOrNil [
	result := aStringOrNil
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
