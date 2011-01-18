Class {
	#name : #MJFAMIXTableGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> mondrianViasulizationTest [
| mooseModel tuples left right grouped map view |

mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

tuples := mooseModel allTables computeLevenshteinDistancesAmongTheFieldsUsingArrays.

self halt.
tuples := "(tuples select: [:each | each first ownerTable ~= each second ownerTable])" tuples sorted: [:a :b | a first name < b first name].
tuples := tuples collect: [:e| Array with: e first with: e second copy with: e third].

"self halt."

left := (tuples collect: [:each | each first]) asArray .
right := (tuples collect: [:each | each second]) asArray.

"map := IdentityDictionary new.

tuples do: [:each |
	map at: (each first ownerTable name , each first name , each second ownerTable name , each second name) asSymbol ifAbsentPut: [each first -> each second].
	]."


view shape rectangle borderWidth: 0.
	view node: left forIt: [
		view shape label text: [:col | col name].
		view interaction menuMorphBlock: [ :element | element mooseMenuMorph ].
		view interaction nodraggable.
		view nodes: (tuples collect: [:each | each first]) .
		view verticalLineLayout.
	].
	view shape rectangle borderWidth: 0.
	view node: right forIt: [
		view shape label text: [:col | col name].
		view interaction menuMorphBlock: [ :element | element mooseMenuMorph ].
		view interaction nodraggable. 
		view nodes: (tuples collect: [:each | each second]) .
		view verticalLineLayout.
	].
	view horizontalLineLayout horizontalGap: 50.
	view shape line 
		color: Color red; 
		width: [:each | each third ];
		fromPositions: #(rightCenter);
		toPositions: #(leftCenter).
	view 
		edges: tuples
		from: [:each | each first ]
		to: [:each | each second ].
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> renderWithArrays [

	| mooseModel tuples matrixRenderer names left right |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

	tuples := mooseModel allTables computeLevenshteinDistancesAmongTheFieldsUsingArrays.
	
	left := (tuples collect: [:each | each first name]) asArray sorted: [:a :b | a name < b name].
	right := (tuples collect: [:each | each second name]) asArray sorted: [:a :b | a name < b name].
	
	
	
	matrixRenderer := MOMatrixRenderer new.
	
	matrixRenderer cellSize: 20.
	matrixRenderer cellPadding: 5.
	
	"matrixRenderer cellFunction: [:row :col |
		|tuple |
		tuple := matrix detect: [:tup| (tup first name = row) and: [(tup first name = col)]] ifNone: [nil].
	]."
		
	matrixRenderer render
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> renderr [

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

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testComputeLevenshteinDistancesAmongFieldsWithMalWeightedEdge [

	| mooseModel distances transposed |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allFKAssociations size = 2).
	self assert: (mooseModel allColumns size = 75).

	distances := mooseModel allTables computeLevenshteinDistancesAmongFieldsWithMalWeightedEdge.
	
	self assert: (distances size = 5).
	self assert: (distances allSatisfy: [:each | each isKindOf: MalWeightedEdge]).
	
	self assert: (distances first from isKindOf: MJFAMIXColumn).
	self assert: (distances first from name = 'AD_Client_ID'). 
	self assert: (distances first from ownerTable name = 'A_Asset'). 
	self assert: (distances first to isKindOf: MJFAMIXColumn).
	self assert: (distances first to name = 'AD_Client_ID'). 
	self assert: (distances first to ownerTable name = 'A_Asset_Group').
	self assert: (distances first weight = 0).
	
	self assert: (distances second from isKindOf: MJFAMIXColumn).
	self assert: (distances second from name = 'AD_Org_ID'). 
	self assert: (distances second from ownerTable name = 'A_Asset'). 
	self assert: (distances second to isKindOf: MJFAMIXColumn).
	self assert: (distances second to name = 'AD_Org_ID'). 
	self assert: (distances second to ownerTable name = 'A_Asset_Group').
	self assert: (distances second weight = 0). 
	
	self assert: (distances third from isKindOf: MJFAMIXColumn).
	self assert: (distances third from name = 'AD_Client_ID'). 
	self assert: (distances third from ownerTable name = 'A_Asset'). 
	self assert: (distances third to isKindOf: MJFAMIXColumn).
	self assert: (distances third to name = 'AD_Client_ID'). 
	self assert: (distances third to ownerTable name = 'AD_User').
	self assert: (distances third weight = 0). 
	
	self assert: ((distances at: 4) from isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 4) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 4) to isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 4) to name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) to ownerTable name = 'AD_User').
	self assert: ((distances at: 4) weight = 0). 
	
	self assert: ((distances at: 5) from isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 5) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 5) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 5) to isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 5) to name = 'AD_OrgTrx_ID'). 
	self assert: ((distances at: 5) to ownerTable name = 'AD_User').
	self assert: ((distances at: 5) weight = 3). 
]

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
