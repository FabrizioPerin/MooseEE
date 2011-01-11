Class {
	#name : #MJFAMIXTableGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testComputeLevenshteinDistancesAmongTheFields [

	| mooseModel matrix transposed |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allFKAssociations size = 2).
	self assert: (mooseModel allColumns size = 75).

	matrix := mooseModel allTables computeLevenshteinDistancesAmongTheFields.
	
	self assert: (matrix size = (76*76)).
	 
	transposed := matrix transposed. 
	
	(2 to: transposed rowSize) asArray do: [:rowIndex |
		(rowIndex to: transposed columnSize) asArray do: [:colIndex | 
			self assert: ((transposed at: rowIndex and: colIndex) = nil)]].
	
	
	self assert: ((matrix at: 1 and: 5) name = 'Created').
	self assert: ((matrix at: 6 and: 1) name = 'CreatedBy').	
	self assert: ((matrix at: 5 and: 6) = 2).

	self assert: ((matrix at: 6 and: 5) = nil).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testRenderr [

	| mooseModel matrix matrixRenderer toShow names |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

	matrix := mooseModel allTables computeLevenshteinDistancesAmongTheFields.
	
	matrixRenderer := MOMatrixRenderer new.
	
	matrixRenderer cellSize: 40.
	matrixRenderer cellPadding: 5.	
		
	names := (matrix columnAt: 1) asOrderedCollection collect: #name.
	names removeFirst.
	
	matrixRenderer columns: (names).
	matrixRenderer rows: (names).
	
	toShow := Set new.

	(2 to: matrix rowSize) asArray do: [:rowIndex |
			((rowIndex + 1) to: matrix columnSize) asArray do: [:colIndex |
				| el |
				el := matrix 
					at: rowIndex 
					and: colIndex.
				((el ~= nil) and: [el < 4]) ifTrue: [toShow add: {(matrix at: 1 and: rowIndex) name . (matrix at: colIndex and: 1) name . el}]	
			]]. 
	toShow inspect.
	matrixRenderer cellFunction: [:row :col |
		 |tuples res|
		tuples := (toShow select: [:tuple| tuple first = row]).
		res := tuples detect: [:tup| tup second = col] ifNone: [nil].
		res ifNotNil: [res third]
	].
		
	matrixRenderer render
]
