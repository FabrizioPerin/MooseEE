Class {
	#name : #MJLongestCommonSubSequenceServiceClass,
	#superclass : #Object,
	#category : #'Moose-JEE-Algos'
}

{ #category : #algorithms }
MJLongestCommonSubSequenceServiceClass >> lcsLenghtOf: aSequence and: anotherSequence [
	| xLength yLength valuesMatrix directionsMatrix result |

	result := Dictionary new.

	xLength := aSequence size.
	yLength := anotherSequence size.
		
	directionsMatrix := MalArrayMatrix new: xLength @ yLength.
	valuesMatrix := MalArrayMatrix new: xLength @ yLength. 

	(1 to: xLength) do: [:index | valuesMatrix at: index and: 0 put: 0 ].	
	(1 to: yLength) do: [:index | valuesMatrix at: 0 and: index put: 0 ].	
	
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
							directionsMatrix at: rowIndex and: colIndex put: #l.] ] ] ].

	result at: #directionsMatrix ifAbsentPut: [directionsMatrix].
	result at: #valuesMatrix ifAbsentPut: [valuesMatrix].
	result at: #aSequence ifAbsentPut: [aSequence].
	result at: #anotherSequence ifAbsentPut: [anotherSequence].
	
	^result
]

{ #category : #algorithms }
MJLongestCommonSubSequenceServiceClass >> printLCSOf: aSequence using: aDirectionsMatrix havingRowSize: xLength andColumnSize: yLength [
	| anotherSequence valuesMatrix directionsMatrix |

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
