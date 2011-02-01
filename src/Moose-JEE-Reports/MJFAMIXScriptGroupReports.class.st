Class {
	#name : #MJFAMIXScriptGroupReports,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> browser [
	| browser |
	browser := GLMTabulator new.
	browser column: #allmaps; column: #map.
	browser transmit to: #allmaps; andShow: [:a | 
  	a list 
		title: 'Scripts and table mapping';
		display: [ :maps |
				maps];
		showOnly: 50].
	
	browser transmit to: #visualization; from: #allmaps; andShow: [:a | 
		a mondrian 
			title: 'Relations';
			painting: [:view :map |
				| scripts tables maps|

				"maps := result select: [:each | each from = map from ]."
				
				scripts  := map from withDeepInvokingScripts.
				scripts := (scripts flatCollect: [:each | each withDeepInvokedScripts]) asSet.
				maps := result select: [:each | scripts includes: each from ].
				
				tables := (maps collect: [:each | each to]) asSet.
	
				view shape rectangle text: [:script | script container isNil ifTrue: [script name] ifFalse: [script container]]; fontSize: 10.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: scripts.
				
				view shape tableShape.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: tables.

				view edges: maps from: #from to: #to.
				view treeLayout verticalGap: 80]].
	
	^ browser startOn: self result

"| browser |
	browser := GLMTabulator new.
	browser title: 'Scripts and tables'.
	browser
		column: #relations;
		column: #visualization;
		column: #details.
	
	browser transmit to: #relations; andShow: [:a |
    		a list 
			title: 'Scripts and table mapping';
		     	display: [ :mm |
				| maps |
				maps :=((mm allMaps select: [:map | map from isKindOf: PXSScript]) sorted: [:first :second | first from name < second from name]) asSet.
				maps];
			showOnly: 100].
	
	browser transmit to: #visualization; from: #relations; andShow: [:a | 
		a mondrian 
			title: 'Relations';
			painting: [:view :map |
				| scripts tables maps|
				maps :=((map mooseModel allMaps select: [:el | el from isKindOf: PXSScript]) sorted: [:first :second | first from name < second from name]) asSet.
				maps := maps select: [:each | each from = map from ].
				
				scripts  := (maps collect: [:each | each from]) asSet.
				tables := (maps collect: [:each | each to]) asSet.
	
				view shape rectangle text: [:script | script container isNil ifTrue: [script name] ifFalse: [script container]]; fontSize: 10.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: scripts.
				
				view shape tableShape.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: tables.

				view edges: maps from: #from to: #to.
				view treeLayout verticalGap: 80]].
		
	browser transmit 
		to: #details; 
		from: #visualization; 
		when: [:el | el isKindOf: PXSScript];
		andShow: [:a | 
			a text
				title: [:el | el name];
				display: [:el | el sourceText]].
	
	browser transmit 
		to: #details; 
		from: #visualization; 
		when: [:el | el isKindOf: MJFAMIXTable];
		andShow: [:a | 
			a mondrian
				title: [:el | el name];
				painting: [:view :el | el viewTableOn: view]].
	
	browser transmit 
		to: #details; 
		from: #visualization; 
		when: [:el | el isKindOf: MJFAMIXMapping];
		andShow: [:a | 
			a text
				title: [:el | el from name];
				display: [:el | el from sourceText]].
	
	browser transmit 
		to: #details->#selectionInterval; 
		from: #visualization;
		when: [:el | el isKindOf: MJFAMIXMapping];
		transformed: [:el |
			| last values min rightPlace |
			values := OrderedCollection new.
			
			last := el from sourceText findString: 'execselect' startingAt: 1 caseSensitive: false.
			[last > 0] whileTrue:
				[values add: last.
				last := el from sourceText findString: 'execselect' startingAt: (last + 1) caseSensitive: false].
			
			last := el from sourceText findString: 'execsql' startingAt: 1 caseSensitive: false.
			[last > 0] whileTrue:
				[values add: last.
				last := el from sourceText findString: 'execsql' startingAt: (last + 1) caseSensitive: false].

			min := el from sourceText size.
			rightPlace := 0.

			values do:[:index |
				| tablePosition |
				tablePosition := (el from sourceText findString: (el to name) startingAt: index).
				((tablePosition - index) > 0 and: [(tablePosition - index) <= min ]) ifTrue: [min := (tablePosition - index). rightPlace := tablePosition. ]].
			
			rightPlace to: (rightPlace + el to name size).
			].
			

	^browser"
]

{ #category : #'as yet unclassified' }
MJFAMIXScriptGroupReports >> computeResult [

	| invocations scripts maps |

"	invocations := self model allInvocations select: [:each | (each from isMemberOf: PXSScript) and: [
											(each anyCandidate isMemberOf: PXSScript)]].
					
	scripts := invocations collect: [:each | each from].
	scripts := (scripts addAll: (invocations flatCollect: [:each | each candidates])) asSet."

	maps := ((self model allMaps select: [:map | map from isKindOf: PXSScript]) sorted: [:first :second | first from name < second from name]) asSet.

	"maps := self model allMaps select: [:each | scripts includes: each from ]. "

	^maps
	
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
