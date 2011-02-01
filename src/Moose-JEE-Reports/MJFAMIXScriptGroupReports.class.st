Class {
	#name : #MJFAMIXScriptGroupReports,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> browser [
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
      title: 'Leventhein dinstances among fields';
      display: [ :edges |
      | res stream distances |
		stream := CrLfFileStream forceNewFileNamed: 'potential_foreign_keys.txt'.
		distances := edges select: [:each | each weight < self cleanUpThreshold].
		distances := distances sorted: [:first :second | first weight < second weight ].
		distances do: [:each |
			stream nextPutAll: (each from ownerTable name , '::' , each from name , String tab , '--- ', each weight asString , ' --->' , String tab , each to ownerTable name , '::' , each to name , String cr).].
		stream close.
		distances.
	];
	showOnly: 50.].
  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> cleanUpThreshold [
	"this method return the threshold used by this report to clean up the results. 
	E.g. with a threshold of 1 there will be visualized only distances euqlas to 0"
	^1
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> computeResult [

	| invocations scripts maps |

	invocations := self model allInvocations select: [:each | (each from isMemberOf: PXSScript) and: [
											(each anyCandidate isMemberOf: PXSScript)]].
					
	scripts := invocations collect: [:each | each from].
	scripts := (scripts addAll: (invocations flatCollect: [:each | each candidates])) asSet.
	
	maps := self model first mooseModel allMaps select: [:each | scripts includes: each from ]. 

	^scripts
	
	"maps := group first mooseModel allMaps select: [:each | scripts includes: each from ]. 
	tableToExclude := group first mooseModel allFKAssociations collect: [:each | each from ownerTable].
	tableToExclude := (tableToExclude addAll: (group first mooseModel allFKAssociations collect: [:each | each to ownerTable])) asSet.

maps := maps reject: [:each | tableToExclude includes: each to].

view shape rectangle text: #name.
view nodes: scripts.

view shape tableShape.
view nodes: (maps collect: #to).

view shape line color: Color red.
view edges: group from: #sender to:#anyCandidate.

view shape line color: Color lightGray.
view edges: maps from: #from to: #to.

view dominanceTreeLayout."
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> explanation [ 
  ^ 'This report aim to identify potential missing link between two database table considering the relation among scripts.

The report shows all the scripts that has a connection with one or more other scripts and with a table'
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> label [ 
  ^ 'Potential missing links between tebles'
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> viewLevenshteinDistancesAmong: aTableGroup and: aCollectionOfEdges On: view [
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
