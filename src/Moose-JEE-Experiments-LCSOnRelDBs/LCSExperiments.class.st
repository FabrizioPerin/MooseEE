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
LCSExperiments >> calculateLDAmongTablesFieldsCleanedUpAndPutResultsInto: aFileName [
	| result distances aStream |
	
	result := self levenshteinDistancesAmongFieldsOf: targetModel allTables.
	
	self cleanUpThreshold: 1.
	
	distances := result select: [:distance | distance weight < self cleanUpThreshold].
	distances := distances sorted: [:first :second | first weight < second weight ].
	aStream := CrLfFileStream forceNewFileNamed: (aFileName , '.csv').
	aStream nextPutAll: ('FROM TABLE NAME' , ';' , 'FROM COLUMN NAME' , ';' , 'TO TABLE NAME' , ';' , 'TO COLUMN NAME' , ';' , 'DISTANCE' , String cr).
	distances do: [:distance | self print: distance amongColumnsAsCSVOn: aStream].
	aStream close
]

{ #category : #accessing }
LCSExperiments >> initialize [
]

{ #category : #amongFields }
LCSExperiments >> levenshteinDistancesAmongFieldsOf: aTableGroup [
	
	| aLevenshteinDistanceStrategy progr tableLeftGroup tableRightGroup result |
	
	tableLeftGroup := aTableGroup asArray.
	tableRightGroup := aTableGroup asArray.
	result := OrderedCollection new.
	aLevenshteinDistanceStrategy := DudeLevenshteinDistanceStrategy threshold: 2.
	progr := 1.
	
	UIManager default
		displayProgress: 'Computing levenshtein distances'
		at: Sensor cursorPoint
		from: 1 
		to: ((tableLeftGroup size * tableRightGroup size)/2) asInteger
		during: [ :bar | 
			bar value: progr.
			
			"these nested loops logically organize the table in a matrix and the computation is done on the whole matrix"
			(1 to: tableLeftGroup size) asArray do: [:rowIndex |
				| columnsPKGroup |
				
				(tableLeftGroup at: rowIndex) hasComposePK
					ifFalse: [columnsPKGroup := (tableLeftGroup at: rowIndex) pkColumns]
					ifTrue: [columnsPKGroup := #()].
				
				(1 to: tableRightGroup size) asArray do: [:colIndex |
					| distance columnsGroup |
					
					((tableRightGroup at: colIndex) = (tableLeftGroup at: rowIndex))
						ifTrue: [columnsGroup := #()]
						ifFalse: [
							"columnsGroup := (tableRightGroup at: colIndex) columns."
							"columnsGroup :=  ((tableRightGroup at: colIndex) columns reject:  [:col | col isPK notNil and: [col isPK] ] ) reject: [:col | col isFK notNil and:[col isFK]]."
							columnsGroup :=  ((tableRightGroup at: colIndex) columns reject:  [:col | col isPK = true]).
							"columnsGroup :=  (tableRightGroup at: colIndex) columns select:  [:col | (col isPK notNil and: [col isPK]) or: [(col isFK notNil and: [col isFK]) or:[col isUnique notNil and:[col isUnique]]]]."].
					
					columnsPKGroup do: [:pk | 
						columnsGroup do: [:col |
							distance := aLevenshteinDistanceStrategy levenshteinDistanceSource: pk name target: col name.
							(distance < 1)  ifTrue: [
								| normalization |
								normalization := (distance asFloat / (pk name size max: col name size)).
								normalization < 0.43 ifTrue: [ 
									result add: (MalWeightedEdge new from: pk; to: col; weight: distance)]]]].
				progr := progr+1.
				bar value: progr]]].
	^result
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
