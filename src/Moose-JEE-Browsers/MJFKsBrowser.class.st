Class {
	#name : #MJFKsBrowser,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Browsers'
}

{ #category : #'as yet unclassified' }
MJFKsBrowser >> browser [
	
	| browser |
	browser := GLMTabulator new.
	browser title: 'Browse Foreign Keys Relations'.
	browser
		column: #tables;
		column: #fkRealations;
		column: #visualization.
	
	browser transmit to: #tables; andShow: [:a |
    		a list 
			title: 'List of tables';
		     	display: [ :mm |
				mm allTables sort: [:first :second | first name < second name].  
				"| maps |
				maps :=((mm allMaps select: [:map | map from isMemberOf: FAMIXClass]) sorted: [:first :second | first from name < second from name]) asSet.
				maps"];
			showOnly: 100].
		
	browser transmit to:#fkRealations; from: #tables; andShow: [:a |
    		a list 
			title: 'List of tables';
		     	display: [ :table | 
				table mooseModel allFKAssociations select: [:each | (each from ownerTable = table) or: [each to ownerTable = table]]];
			showOnly: 100].
	
	browser transmit to: #visualization; from: #tables; andShow: [:a | 
		a mondrian 
			title: 'Relations';
			painting: [:view :table |
				| tables interestingTables |
				
				interestingTables := (table withDeepReferencesTables union: table withDeepReferencedByTables) asSet.
				
				view shape tableShape.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: interestingTables.

				view shape line color: Color lightGray.  
				view edges: table mooseModel allFKAssociations from: [:assoc | assoc sourceColumn ownerTable] to: [:assoc | assoc targetColumn ownerTable].
				
				view horizontalTreeLayout horizontalGap: 80]].

	^browser
]
