Class {
	#name : #MJRimaMappingBrowser,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Experiments-AdempiereCaseStudy'
}

{ #category : #'as yet unclassified' }
MJRimaMappingBrowser >> browser [
	
	| browser |
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
				maps :=((mm allMaps select: [:map | map from isMemberOf: FAMIXClass]) sorted: [:first :second | first from name < second from name]) asSet.
				maps];
			showOnly: 100].
	
	browser transmit to: #visualization; from: #relations; andShow: [:a | 
		a mondrian 
			title: 'Relations';
			painting: [:view :map |
				| scripts tables maps|
				maps :=(map mooseModel allMaps select: [:el | el from isKindOf: FAMIXClass]).
				maps := maps select: [:each | each from = map from ].
				
				scripts  := (maps collect: [:each | each from]) asSet.
				tables := (maps collect: [:each | each to]) asSet.
	
				view shape rectangle text: #name; fontSize: 10.
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
		when: [:el | el isKindOf: FAMIXClass];
		andShow: [:a | 
			a mondrian 
			title: 'Relations';
			painting: [:view :class |
				| classes maps | 
				classes := class withDeepInvokingClasses.
				maps :=class mooseModel allMaps select: [:el | classes includes: el from].
				
				view shape rectangle text: #name.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: classes.
				
				view shape tableShape.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view interaction popupText.
				view nodes: (maps collect: #to).
				
				view edges: maps from: #mapSource to: #mapTarget.
				view edges: class mooseModel allInvocations from: #sender to: #anyCandidate.
				
				view treeLayout.
				
				]].
	
	browser transmit 
		to: #details; 
		from: #visualization; 
		when: [:el | el isKindOf: MJFAMIXTable];
		andShow: [:a | 
			a mondrian
				title: [:el | el name];
				painting: [:view :el | el viewTableOn: view]].
	
	"browser transmit 
		to: #details; 
		from: #visualization; 
		when: [:el | el isKindOf: MJFAMIXMapping];
		andShow: [:a | 
			a text
				title: [:el | el from name];
				display: [:el | el from sourceText]]."
	
	"browser transmit 
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
			]."
			

	^browser
]
