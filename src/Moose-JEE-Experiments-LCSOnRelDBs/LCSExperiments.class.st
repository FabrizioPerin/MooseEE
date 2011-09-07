Class {
	#name : #LCSExperiments,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Experiments-LCSOnRelDBs'
}

{ #category : #'as yet unclassified' }
LCSExperiments class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #amongFields }
LCSExperiments >> computeLCSAmongColumnsOf: aTable and: anotherTable andPutResultsOn: aStream [
	| progr aTablePKs anotherTableColumns |

	aTablePKs := aTable pkColumns.
	anotherTableColumns := anotherTable columns reject: [ :col | col isPK = true ].

	UIManager default
		displayProgress: 'Computing LCS among ' , aTable name , ' and ' , anotherTable name
		at: Sensor cursorPoint
		from: 1
		to: aTablePKs size * anotherTableColumns size
		during: [ :bar | 

			bar value: progr.
			(1 to: aTablePKs size)
				do: [ :pkColIndex | 
					(1 to: anotherTable size)
						do: [ :colIndex | 
							| lcs |
							lcs := MJLongestCommonSubSequence of: (aTablePKs at: pkColIndex) and: (anotherTable at: colIndex).
							lcs computelcsLenght.
							lcs writeResultAsCVSEntryOn: aStream ] ] ]
]

{ #category : #amongFields }
LCSExperiments >> computeLCSAmongColumnsOfAllTables [
	| result distances aStream fileName |
	
	fileName := UITheme builder textEntry: 'Insert a file name (csv extension will be add)'.
	
	(fileName isNil or: [ fileName isEmpty ])
		ifTrue: [ UITheme builder alert: 'Please insert a valid file name' ]
		ifFalse: [ 
			| tables |
			aStream := CrLfFileStream forceNewFileNamed: fileName , '.csv'.
			MJLongestCommonSubSequence writeCVSEntryHeaderOn: aStream.
			tables := targetModel allTables.
		
			UIManager default
				displayProgress: 'Computing LCS among all model''s table'
				at: Sensor cursorPoint
				from: 1
				to: (tables size * tables size \ 2) asInteger
				during: [ :bar | 
					| counter |
					counter := 1.
					bar value: counter.
					(1 to: tables size)
						do: [ :firstIndex | 
							(firstIndex to: tables size)
								do: [ :secondIndex | 
									self computeLCSAmongColumnsOf: (tables at: firstIndex) and: (tables at: secondIndex) andPutResultsOn: aStream.
									counter := counter + 1.
									bar value: counter ] ].
					aStream close ] ]
]

{ #category : #accessing }
LCSExperiments >> initialize [
]

{ #category : #amongFields }
LCSExperiments >> print: aDistance amongColumnsAsCSVOn: aStream [
	aStream nextPutAll: (aDistance from ownerTable name , ';' , aDistance from name , ';' ,  aDistance to ownerTable name , ';' , aDistance to name , ';' , aDistance weight asString , String cr).
]

{ #category : #amongTablesAndFields }
LCSExperiments >> print: aDistance amongTableAndColumnAsCSVOn: aStream [
	aStream nextPutAll: (aDistance from name , ';' , aDistance to ownerTable name , ';' , aDistance to name , ';' , aDistance weight asString , String cr).
]

{ #category : #accessing }
LCSExperiments >> targetModel [
	^ targetModel
]

{ #category : #accessing }
LCSExperiments >> targetModel: anObject [
	targetModel := anObject
]
