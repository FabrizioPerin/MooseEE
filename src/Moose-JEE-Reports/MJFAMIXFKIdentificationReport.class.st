Class {
	#name : #MJFAMIXFKIdentificationReport,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> browser [
	| browser |
	browser := GLMTabulator new.
	browser column: #interestingMaps;" column: #visualization; "column: #distances; column:#dinstVis.

	browser transmit to: #interestingMaps; andShow: [:a |
		a list
			title: 'Maps';
			display: [:maps | (maps collect: #to) asSet]";
			showOnly: 50"].
	
	browser transmit from: #interestingMaps; to: #distances;  andShow: [:a | 
		a list
			title: 'Potential FK relations';
			display: [:table | 
				| scripts tables maps distances|
				
				scripts  := ((result select: [:each | each to = table]) flatCollect: [:each | each from withDeepInvokingScripts]) asSet.
				scripts := (scripts flatCollect: [:each | each withDeepInvokedScripts]) asSet.
				maps := result select: [:each | scripts includes: each from ].
				
				scripts := (maps flatCollect: [:each | each from withDeepInvokingScripts])asSet.
				tables := (maps collect: [:each | each to]) asSet.
				
				distances := tables asMooseGroup levenshteinDistancesAmongFieldsTable.

				distances asSet..
				
				]].
	browser transmit from: #distances; to: #dinstVis; andShow: [:a | 
	    a mondrian
	      title: 'FK Relations';
	      painting: [:view :edge | 
			| tables maps |
			"Starting from the selected edge (from part) pickup all the other edges having the selected one as invoker or invoked element"
			maps := result select: [:each | (edge from = each from) or: [edge from = each to]].
			tables := ((maps) union: (maps collect: [:each | each to ownerTable])) asSet.
	        	self viewLevenshteinDistancesAmong: tables and: maps On: view]].

  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> cleanUpThreshold [
	"this method return the threshold used by this report to clean up the results. 
	E.g. with a threshold of 1 there will be visualized only distances euqlas to 0"
	^1
]

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> computeResult [
	
	| maps lonelyMaps interestingMaps |
	
	maps := self model allMaps select: [:map | map from isKindOf: PXSScript].
	lonelyMaps := maps select: [:each | each from withDeepInvokingScripts size = 1].
	interestingMaps := maps reject: [:each | each from withDeepInvokingScripts size = 1].
	
	^interestingMaps
]

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> explanation [ 
  ^ 'List of data base''s columns that have a levensthein distance among them below 
In the first panel there is the list of column''s distances in a form:
	 
column''s table name>>column name -> column''s table name>>column name (distance)
	
The columns on the left of the association are primary key while the columns on the right don''t have any foreign key constraint defined.
	
By clicking on an entry another panel with a visualization will open showing the tables containing columns that have been found with a distance below the threshold. The columns in blu are primary key. The visualized element are choose like this: 
- pickup the column at the left side of the association
- pickup all the associations that have the selected column as left entity or right entity.
	
E.g. Considering a report with this two associations: TAB1>>COL1 -> TAB2>>COL2 and TAB3>>COL3 -> TAB1COL1. 
By selecting the first association in the visualization you will see TAB3 with the COL3 inside on the left part, TAB1 with the COL1 inside in the middle and TAB2 with the COL2 inside on the right.'
]

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> label [ 
  ^ 'Foreign Key recovery'
]

{ #category : #'as yet unclassified' }
MJFAMIXFKIdentificationReport >> viewLevenshteinDistancesAmong: aTableGroup and: aCollectionOfEdges On: view [
	| mooseModel allInterestingColumns  allInterestingTables builder |

	allInterestingColumns := ((aCollectionOfEdges collect: [:each | each from ]) union: (aCollectionOfEdges collect: [:each | each to])) asSet. 
	"allInterestingTables := ((aCollectionOfEdges collect: [:each | each from ownerTable ]) union: (aCollectionOfEdges collect: [:each | each to ownerTable])) asSet."
	
	view shape tableShape.
	view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
	view interaction popupText.
	view interaction nodraggable.
	view nodes: aTableGroup forEach: [:each |
		| columnToShow |
		columnToShow := each columns select: [:col | allInterestingColumns includes: col].
		view shape rectangle withoutBorder; 
			text: [:col | col name];
			fontColor: [:col | 
				(col isPK notNil and:[col isPK]) 
				ifTrue: [Color blue] 
				ifFalse: [Color black]].
		view interaction menuMorphBlock: [ :col | col mooseMenuMorph ].
		view interaction popupText: [:col |
			| text |
			text := ReadWriteStream with: ''.
			(aCollectionOfEdges select: [:edge | 
				(edge from = col or: [edge to = col])]) do: [:ed |
					text nextPutAll: (ed from ownerTable name , '::' , ed from name , '   --- ', ed weight asString , ' --->   ' , ed to ownerTable name , '::' , ed to name , String cr)].
			text close stringContents.].
		view interaction nodraggable.
		view nodes: columnToShow.
		view verticalLineLayout.].
	
	view shape line color: Color gray.
	"view edges: aCollectionOfEdges from: #from to: #to.

	view shape line color: Color transparent."
	view edges: aCollectionOfEdges from: [:each | each from ownerTable] to: [:each | each to ownerTable].

	view horizontalTreeLayout horizontalGap: 100.
]
