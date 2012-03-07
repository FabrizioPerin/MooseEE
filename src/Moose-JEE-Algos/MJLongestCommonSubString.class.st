Class {
	#name : #MJLongestCommonSubString,
	#superclass : #Object,
	#instVars : [
		'valuesMatrix',
		'result',
		'firstSequence',
		'secondSequence'
	],
	#category : #'Moose-JEE-Algos'
}

{ #category : #'as yet unclassified' }
MJLongestCommonSubString class >> of: aSequence and: anotherSequence [

	^self new
		firstSequence: aSequence;
		secondSequence: anotherSequence.
		
]

{ #category : #algorithms }
MJLongestCommonSubString class >> writeCVSEntryHeaderOn: aStream [
	aStream nextPutAll: ('First Sequence' , ';' , 'Second Sequence' , ';' , 'LCSS size' , ';' , 'LCSSs' , String cr).
	^aStream
]

{ #category : #run }
MJLongestCommonSubString >> computeLCSS [
	self longestCommonSubstring.
	^result
]

{ #category : #accessing }
MJLongestCommonSubString >> firstSequence [
	^ firstSequence
]

{ #category : #initialize }
MJLongestCommonSubString >> firstSequence: anObject [
	firstSequence := anObject
]

{ #category : #initialize }
MJLongestCommonSubString >> initialize [
	super initialize.
	
	self result: nil.
]

{ #category : #initialize }
MJLongestCommonSubString >> initializeValuesMatrix [

	valuesMatrix := MalArrayMatrix new: (firstSequence size + 1) @ (secondSequence size + 1).

	(2 to: valuesMatrix rowSize) do: [:index | valuesMatrix at: index and: 1 put: 0 ].	
	(1 to: valuesMatrix columnSize) do: [:index | valuesMatrix at: 1 and: index put: 0 ].

]

{ #category : #algorithms }
MJLongestCommonSubString >> longestCommonSubstring [
	| xLength yLength z|
	
	
	xLength := firstSequence size.
	yLength := secondSequence size.
	z := 0.
	self initializeValuesMatrix.
	result := OrderedCollection new.
	
	
	(1 to: xLength) do: [:rowIndex |
		(1 to: yLength) do: [:colIndex |
			((firstSequence at: rowIndex) = (secondSequence at: colIndex))
				ifTrue: [
					((rowIndex = 1) and: (colIndex = 1))
						ifTrue: [ valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: 1]
						ifFalse: [ valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: ((valuesMatrix at: (rowIndex + 1-1) and: (colIndex + 1-1)) + 1) ].
					((valuesMatrix at: (rowIndex + 1) and: (colIndex + 1)) > z)
						ifTrue: [ 
							z := valuesMatrix at: (rowIndex + 1) and: (colIndex + 1).
							result := OrderedCollection new].
					((valuesMatrix at: (rowIndex + 1) and:  (colIndex + 1)) = z)
						ifTrue: [ 
							result add: (firstSequence copyFrom: (rowIndex - z + 1) to: rowIndex) ] ]
				ifFalse: [ valuesMatrix at: (rowIndex + 1) and: (colIndex + 1) put: 0 ] ] ].
		
		^result
						
						
]

{ #category : #accessing }
MJLongestCommonSubString >> result [
	result isNil ifTrue: [self computeLCSS].
	^ result
]

{ #category : #initialize }
MJLongestCommonSubString >> result: aStringOrNil [
	result := aStringOrNil
]

{ #category : #accessing }
MJLongestCommonSubString >> secondSequence [
	^ secondSequence
]

{ #category : #initialize }
MJLongestCommonSubString >> secondSequence: anObject [
	secondSequence := anObject
]

{ #category : #accessing }
MJLongestCommonSubString >> valuesMatrix [
	^ valuesMatrix
]

{ #category : #export }
MJLongestCommonSubString >> writeResultAsCVSEntryOn: aStream [
	
	aStream nextPutAll: (firstSequence , ';' , secondSequence , ';' , ((result size = 0) ifTrue: [0 asString] ifFalse: [result first size asString ]) , ';' , result asString , String cr).
	^aStream
]

{ #category : #export }
MJLongestCommonSubString >> writeResultAsCVSEntryWithHeaderOn: aStream [
	self class writeCVSEntryHeaderOn: aStream.
	self writeResultAsCVSEntryOn: aStream.
	^aStream
]
