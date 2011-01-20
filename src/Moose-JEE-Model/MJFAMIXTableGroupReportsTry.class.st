Class {
	#name : #MJFAMIXTableGroupReportsTry,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Model-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> browser [
  | browser |
  browser := GLMTabulator new.
  browser column: #code; column: #map.
  browser transmit to: #map; from: #code; andShow: [:a | 
    a mondrian
      title: 'FK Relations';
      painting: [:view :edge | 
		| tables edges |
		edges := result select: [:each | (edge from = each from) or: [edge from = each to]].
		tables := ((edges collect: [:each | each from ownerTable]) union: (edges collect: [:each | each to ownerTable])) asSet.
        self viewLevenshteinDistancesAmong: tables and: edges On: view]].

  browser transmit to: #code; andShow: [:a | 
    a list 
      title: 'Facade class';
      display: [ :edges |
      | res stream distances |
		stream := CrLfFileStream forceNewFileNamed: 'potential_foreign_keys.txt'.
		distances := edges sorted: [:first :second | first weight < second weight ].		
		distances do: [:each |
			stream nextPutAll: (each from ownerTable name , '::' , each from name , '   --- ', each weight asString , ' --->   ' , each to ownerTable name , '::' , each to name , String cr).].
		stream close.
		distances.
	];
	showOnly: 50.].
  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> computeResult [
  ^ self model allTables computeLevenshteinDistancesAmongFieldsWithMalWeightedEdge.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> explanation [ 
  ^ 'Analyses on a table group '
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> label [ 
  ^ 'Foreign Key recovery'
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> viewCell: aMatrix on: view [
  view shape label 
    text: [:each | each]; 
    fontColor: [:each | each isNumber
						ifTrue: [(each < 4)
								ifTrue: [Color blue]
								ifFalse: [Color gray]]].
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> viewFKRelationsAmong: aTableGroup On: aView [

| mooseModel tuples left right grouped map |
mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
tuples := mooseModel allTables computeLevenshteinDistancesAmongTheFieldsUsingArrays select: [:each | each third < 3].
aView nodes: mooseModel allTables forEach: [:each |
	aView shape rectangle borderWidth: 0; text: [:col | col name].
	aView nodes: each columns.
	aView horizontalTreeLayout ].
aView shape line width: #third.
aView edges: tuples from: #first to: #second.
aView shape line color: Color transparent.
aView edges: tuples from: [:each | each first ownerTable] to: [:each | each second ownerTable].
aView horizontalTreeLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> viewLevenshteinDistancesAmong: aTableGroup On: view [
		| mooseModel edges allInterestingColumns  allInterestingTables |

	"mooseModel := JEETestModels new sampleMooseModelContainingJustADB."

	edges := result computeLevenshteinDistancesAmongFieldsWithMalWeightedEdge.
	"edges := edges select: [:edge | edge weight < 3]."
	
	allInterestingColumns := ((edges collect: [:each | each from ]) union: (edges collect: [:each | each to])) asSet. 
	allInterestingTables := ((edges collect: [:each | each from ownerTable ]) union: (edges collect: [:each | each to ownerTable])) asSet. 
	
	view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
	view nodes: allInterestingTables forEach: [:each |
		| columnToShow |
		columnToShow := each columns select: [:col | allInterestingColumns includes: col].
		view shape rectangle borderWidth: 0; text: [:col | col name].
		view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
		view interaction popupText: [:col |
			| text |
			text := ReadWriteStream with: ''.
			(edges select: [:edge | 
				(edge from = col or: [edge to = col])]) do: [:ed|
					text nextPutAll: (ed from ownerTable name , '::' , ed from name , '   --- ', ed weight asString , ' --->   ' , ed to ownerTable name , '::' , ed to name , String cr)].
			text asString].
		view nodes: columnToShow.
		view verticalLineLayout].
	
	view shape verticalOrthogonalLine color: Color transparent.
	"view edges: edges from: #from to: #to.

	view shape line color: Color transparent."
	view edges: edges from: [:each | each from ownerTable] to: [:each | each to ownerTable].

	view treeLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> viewLevenshteinDistancesAmong: aTableGroup and: aCollectionOfEdges On: view [
		| mooseModel allInterestingColumns  allInterestingTables builder |

	allInterestingColumns := ((aCollectionOfEdges collect: [:each | each from ]) union: (aCollectionOfEdges collect: [:each | each to])) asSet. 
	"allInterestingTables := ((aCollectionOfEdges collect: [:each | each from ownerTable ]) union: (aCollectionOfEdges collect: [:each | each to ownerTable])) asSet. "
	builder := MOFormsBuilder new.
	builder column; pref.
	builder row; pref; row; pref.
	
	
	
	builder 	x: 1 
		y: 1 
		add: (MORectangleShape new withoutBorder
				text: [ :table | table name];
				fontSize: 10;
				textAlignment: #center;
				textPadding: 1).
	
	view shape rectangle text: [:each | each name].
	view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
	view nodes: aTableGroup forEach: [:each |
		| columnToShow |
		columnToShow := each columns select: [:col | allInterestingColumns includes: col].
		view shape rectangle borderWidth: 0; text: [:col | col name].
		view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
		view interaction popupText: [:col |
			| text |
			text := ReadWriteStream with: ''.
			(aCollectionOfEdges select: [:edge | 
				(edge from = col or: [edge to = col])]) do: [:ed|
					text nextPutAll: (ed from ownerTable name , '::' , ed from name , '   --- ', ed weight asString , ' --->   ' , ed to ownerTable name , '::' , ed to name , String cr)].
			text asString].
		view nodes: columnToShow.
		view verticalLineLayout].
	
	view shape line color: Color red.
	view edges: aCollectionOfEdges from: #from to: #to.

	view shape line color: Color transparent.
	view edges: aCollectionOfEdges from: [:each | each from ownerTable] to: [:each | each to ownerTable].

	view horizontalTreeLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReportsTry >> viewMatrix: aMatrix on: view [
	view shape rectangle.
	view interaction nodraggable.
	view node: 'matrix' forIt: [
		view shape rectangle.
		view interaction nodraggable.
		view nodes: aMatrix asArray forEach: [:node | 
			self viewCell: node on: view.
			view gridLayout]].
	view gridLayout.
]
