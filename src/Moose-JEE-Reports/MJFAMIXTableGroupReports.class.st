Class {
	#name : #MJFAMIXTableGroupReports,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> browser [
  | browser |
  browser := GLMTabulator new.
  browser column: #code; column: #map.

	browser transmit to: #code; andShow: [:a | 
		a list 
		title: 'Leventhein dinstances among fields';
	      display: [ :edges |
	 	     | res distances |
			distances := edges select: [:each | each weight < self cleanUpThreshold].
			distances := distances sorted: [:first :second | first weight < second weight ].
			distances];
		showOnly: 50.
		a 
			act: [:f :edges | 
				| stream distances |
				self halt.
				distances := edges select: [:each | each weight < self cleanUpThreshold].
				distances := distances sorted: [:first :second | first weight < second weight ].
				stream := MultiByteFileStream forceNewFileNamed: 'potential_foreign_keys.txt'.
				edges do: [:each | self print: each asStringOn: stream].
				stream close] 
			entitled: 'Export as string'.
		a 
			act: [:f :edges | 
				| stream distances |
				distances := edges select: [:each | each weight < self cleanUpThreshold].
				distances := distances sorted: [:first :second | first weight < second weight ].
				stream := CrLfFileStream forceNewFileNamed: 'potential_foreign_keys.csv'.
				distances do: [:each | self print: each asCSVOn: stream].
				stream close] 
			entitled: 'Export as CSV'.
		].

	browser transmit to: #map; from: #code; andShow: [:a | 
	    a mondrian
	      title: 'FK Relations';
	      painting: [:view :edge | 
			| tables edges |
			"Starting from the selected edge (from part) pickup all the other edges having the selected one as invoker or invoked element"
			edges := result select: [:each | (edge from = each from) or: [edge from = each to]].
			tables := ((edges collect: [:each | each from ownerTable]) union: (edges collect: [:each | each to ownerTable])) asSet.
	        	self viewLevenshteinDistancesAmong: tables and: edges On: view]].

	^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> cleanUpThreshold [
	"this method return the threshold used by this report to clean up the results. 
	E.g. with a threshold of 1 there will be visualized only distances euqlas to 0"
	^1
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> computeResult [
  ^ self model allTables levenshteinDistancesAmongFieldsTable.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> explanation [ 
  ^ 'List of data base''s columns that have a levensthein distance among them below ', self cleanUpThreshold asString , '
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
MJFAMIXTableGroupReports >> label [ 
  ^ 'Foreign Key recovery'
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> print: aDistance asCSVOn: aStream [

	aStream nextPutAll: (aDistance from ownerTable name , ';' , aDistance from name , ';' ,  aDistance to ownerTable name , ';' , aDistance to name , ';' , aDistance weight asString , String cr).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> print: aDistance asStringOn: aStream [

	aStream nextPutAll: (aDistance from ownerTable name , '::' , aDistance from name , String tab , '--- ', aDistance weight asString , ' --->' , String tab , aDistance to ownerTable name , '::' , aDistance to name , String cr).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> viewLevenshteinDistancesAmong: aTableGroup and: aCollectionOfEdges On: view [
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
