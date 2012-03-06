Class {
	#name : #MJCCLCSExperiments,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCCLCSExperiments class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #amongFields }
MJCCLCSExperiments >> exp1 [
	| result distances aStream fileName |
	
	fileName := UITheme builder textEntry: 'Insert a file name (csv extension will be add)'.
	
	(fileName isNil or: [ fileName isEmpty ])
		ifTrue: [ UITheme builder alert: 'Please insert a valid file name' ]
		ifFalse: [ 
			| tables |
			aStream := MultiByteFileStream forceNewFileNamed: fileName , '.csv'.
			MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
			tables := targetModel allTables.
		
			UIManager default
				displayProgress: 'Computing LCS among all model tables'
				at: Sensor cursorPoint
				from: 1
				to: ((tables size * tables size) / 2) asInteger
				during: [ :bar | 
					| counter |
					counter := 1.
					bar value: counter.
					(1 to: tables size)
						do: [ :firstIndex | 
							(firstIndex to: tables size)
								do: [ :secondIndex | 
									| lcsAlgo |
									lcsAlgo := MJLongestCommonSubSequence 
													of: (tables at: firstIndex)
													and: (tables at: secondIndex).
									lcsAlgo computelcsLenght.
									lcsAlgo writeResultAsCVSEntryOn: aStream.
									counter := counter + 1.
									bar value: counter ] ].
					aStream close ] ]
]

{ #category : #accessing }
MJCCLCSExperiments >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJCCLCSExperiments >> targetModel: anObject [
	targetModel := anObject
]
