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
				| tables interestingFKAssociation |
				
				interestingFKAssociation := table mooseModel allFKAssociations select: [:each | (each from ownerTable = table) or: [each to ownerTable = table]].
				
				tables := ((interestingFKAssociation collect: [:each | each targetTable ownerTable]) union: (interestingFKAssociation collect: [:each | each sourceTable ownerTable]))  asSet.
	
				view shape tableShape.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: tables.

				view shape line color: Color lightGray.  
				view edges: interestingFKAssociation from: [:assoc | assoc sourceTable ownerTable] to: [:assoc | assoc targetTable ownerTable].
				
				view horizontalTreeLayout horizontalGap: 80]].

	^browser
]
