Class {
	#name : #MJFAMIXTableGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #meta }
MJFAMIXTableGroup class >> annotation [

	<MSEClass: #MJFAMIXTableGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> levenshteinDistancesAmongFieldsTable [
	
	| aLevenshteinDistanceStrategy progr tableLeftGroup tableRightGroup result |
	
	tableLeftGroup := self asArray.
	tableRightGroup := self asArray.
	result := OrderedCollection new.
	aLevenshteinDistanceStrategy := DudeLevenshteinDistanceStrategy threshold: 2.
	progr := 1.
	
	UIManager default
		displayProgress: 'Computing levenshtein distances'
		at: Sensor cursorPoint
		from: 1 
		to: ((tableLeftGroup size * tableRightGroup size)/2) asInteger
		during: [ :bar | 
			bar value: progr.
			
			(1 to: tableLeftGroup size) asArray do: [:rowIndex |
				| columnsPKGroup |
				
				columnsPKGroup := (tableLeftGroup at: rowIndex) columns select: [:col | col isPK notNil and: [col isPK] ].
				
				((rowIndex + 1) to: tableRightGroup size) asArray do: [:colIndex |
					| distance columnsGroup |
					
					columnsGroup := (tableRightGroup at: colIndex) columns reject: [:col | col isFK notNil and:[col isFK]].
					columnsPKGroup do: [:pk | 
						columnsGroup do: [:col |
							distance := aLevenshteinDistanceStrategy levenshteinDistanceSource: pk name target: col name.
							(distance < 4)  ifTrue: [
								| normalization |
								normalization := (distance asFloat / (pk name size max: col name size)).
								normalization < 0.43 ifTrue: [ 
									result add: (MalWeightedEdge new from: pk; to: col; weight: distance)]]]].
				progr := progr+1.
				bar value: progr]]].
	^result
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> ranked [
	^(((PageRank new
	referenced: [:element |
		(element isMemberOf: MJFAMIXTable) ifTrue: [ element mappedNamedEntities] ifFalse: [
		(element isMemberOf: FAMIXClass) ifTrue: [ element clientClasses] ifFalse: [#()]]
		];
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea ])
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewDBTables [
	"<menuItem: 'View DB Tables' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewDBTablesOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewDBTablesOn: view [
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view node: #tables forIt: [ 
		(self sorted: [:a :b | a name < b name ])  do: [:table | 
				table viewDBTableOn: view.].
			view gridLayout].
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTableRank [
	<menuItem: 'Table Rank' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTableRankOn: view.
	^ view openWithStatusbar title: 'Table Rank'
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTableRankOn: view [ 
	| objects |
	
	objects := self ranked.
	
	view shape label
		text: [:each | each key name , (each value integerPart asString , '.' , each value fractionPart asString asString sliceFrom: 1 to: 3 )].	
	view nodes: objects.
	
	view bottomFlowLayout maxWidth: 600
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTables [
	<menuItem: 'View Tables' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTablesFKs [
	<menuItem: 'View Tables with FK Relations' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesFKsOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTablesFKsOn: view [
	
	self viewTablesOn: view.

	view shape line color: Color red.
	"view edges: self mooseModel allFKAssociations from: [:each | each sourceTable]  to: [:each | each targetTable].

	view shape line color: Color transparent."
	view edges: self mooseModel allFKAssociations from: [:each | each sourceTable ownerTable ]  to: [:each | each targetTable ownerTable].
	
	view horizontalTreeLayout  horizontalGap: 150.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewTablesOn: view [
	
	self do: [:table |
		table viewTableOn: view].
	view gridLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewUMLTablesWithEJBeans [
	"<menuItem: 'Tables with Entity Beans UML class diagram' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesWithEJBeansOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewUMLTablesWithEJBeansOn: view [
	
	| lonelyTables notLonelyTables |	
	
	lonelyTables := self reject: [:each | each inUse].
	notLonelyTables := self select: [:each | each inUse].
	
	notLonelyTables isEmpty ifFalse: [
		view interaction nodraggable.
		view shape rectangle withoutBorder.
		view node: #notLonelyTables forIt: [
			view interaction nodraggable.
			view shape rectangle withoutBorder.
			view nodes: notLonelyTables forEach: [:table |
						table mappedNamedEntities first implementedEntityBean viewUMLOfImplementorOn: view.
						table viewTableUsageOn: view.
						view shape line.
						view edges: table mooseModel allMaps from: #mapSource to: #mapTarget.
						view treeLayout.].
			view gridLayout]].

	lonelyTables isEmpty ifFalse: [
		view shape rectangle withoutBorder.
		view interaction nodraggable.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Tables' ].
		view node: lonelyTables forIt: [
			view shape rectangle withoutBorder.
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view interaction nodraggable.
			view nodes: lonelyTables forEach: [:table | table viewTableUsageOn: view.]. "using: view shape umlClassDiagramLikeForTable."
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

]
