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

{ #category : #utilities }
MJFAMIXTableGroup >> computeDeriveDependenciesFromSourceCode [
	"This method compute derived dependencies considering the relations among software entities. 
	1- the algorithm cycle on all the tables;
	2- for each table we pick all the maps pointing to this table
	3- starting from this maps we build an invokation call graph and we pick up all the other maps that we can find
	4- finally we create a derived dependency amongs all the table that are involved in all the maps.
	
	Note: there is a condition that avoid the creation of multiple derived dependency among two classes.
	
	
	considering the invokation call graph starting from the classes on the of the classes we find all other maps that are involve and consequently all the table that are involved in potential relations"

	self do: [:table |
		| startingMaps invokingClasses allInterestingClasses interestingMaps tableToConnect |
		
		startingMaps := table mooseModel allMaps select: [:each | each to = table].
		
		invokingClasses := OrderedCollection new.
		startingMaps do: [:each |
			(each from isMemberOf: FAMIXClass) ifTrue: [invokingClasses addAll: each from withDeepInvokingClasses]].
		invokingClasses := invokingClasses asSet.
		
		allInterestingClasses := (invokingClasses flatCollect: [:class | class withDeepInvokedClasses]) asSet.
		
		"now that i have all tables i look for all the mapping that i am interest in"
		interestingMaps := (table mooseModel allMaps select: [:each | allInterestingClasses includes: each from]) asSet.
		
		tableToConnect := (interestingMaps collect: #mapTarget) asSet sorted: [:a :b | a name < b name].

		(1 to: tableToConnect size) do: [:rowIndex | 
			((rowIndex + 1) to: tableToConnect size) do: [:colIndex |
				(self mooseModel allDerivedDependencies anySatisfy: [:each | (each source = (tableToConnect at: rowIndex)) and: [(each target = (tableToConnect at: colIndex))]]) ifFalse: [ 
					| dep |
					dep := MJFAMIXDerivedDependency new isDirected: false.
					dep source: (tableToConnect at: rowIndex).
					dep target: (tableToConnect at: colIndex).
					dep rationale: 'Connection derived from connections among source code elements.'.
				
					(tableToConnect at: rowIndex) addOutgoingDerivedDependency: dep.
					(tableToConnect at: colIndex) addIncomingDerivedDependency: dep.
					self mooseModel withoutAnnounceAdd: dep]]]
	]
	
]

{ #category : #utilities }
MJFAMIXTableGroup >> computeDeriveDependenciesFromSourceCodeNOTWORKiNG [

| tables groups classesFromThisTable maps allInvolvedClasses mapsToStartWith table |


mapsToStartWith := self mooseModel allMaps select: [:each | each to = table].

"all tables mapped directly or mapped through their columns"
"tables := (self mooseModel allMaps collect: [:each | 
			(each to isMemberOf: MJFAMIXTable)
				ifTrue: [each to] 
				ifFalse: [each to ownerTable]]) asSet."
			
"maps := (self mooseModel allMaps select: [:each | tables includes: each to]) asSet .  			

allInvolvedClasses := OrderedCollection new.

maps do: [:each | 
			each from isScript ifTrue: [each from withDeepInvokingScripts].
			each from isClass ifTrue: [allInvolvedClasses addAll: each from withDeepInvokingClasses].
			each from isMethod ifTrue: [allInvolvedClasses addAll: each from parentType withDeepInvokingClasses]]."

"Select all the maps that refer to one of the element of self (table group)"
maps := (self mooseModel allMaps select: [:each | 
			(each to isMemberOf: MJFAMIXTable)
				ifTrue: [self includes: each to ] 
				ifFalse: [self includes: each to ownerTable]]) asSet.

maps do: [:map |
		| mapsPointingThisTable allClassesFromATable interestingMaps classesPointingThisTableWithDeepInvokingClasses  |
		
		(map to isMemberOf: MJFAMIXTable) 
			ifTrue: [table :=  map to] 
			ifFalse: [table := map to ownerTable].
		
		mapsPointingThisTable := self mooseModel allMaps select: [:each | each to = table].
		
		classesPointingThisTableWithDeepInvokingClasses := OrderedCollection new.
		mapsPointingThisTable do: [:each |
					each from isClass ifTrue: [classesPointingThisTableWithDeepInvokingClasses addAll: each from withDeepInvokingClasses].
					each from isMethod ifTrue: [classesPointingThisTableWithDeepInvokingClasses addAll: each from parentType withDeepInvokingClasses]].		
		classesPointingThisTableWithDeepInvokingClasses := classesPointingThisTableWithDeepInvokingClasses asSet.
		 
		mapsPointingThisTable := mapsPointingThisTable select: [:each | each from isMemberOf: FAMIXClass]. 
		classesFromThisTable := (classesPointingThisTableWithDeepInvokingClasses flatCollect: [:each | each from withDeepInvokingClasses]) asSet.
				
		allClassesFromATable := (classesFromThisTable flatCollect: [:each | each withDeepInvokedClasses]) asSet.
		
		interestingMaps := self mooseModel allMaps select: [:each | allClassesFromATable includes: each from].
		
		(1 to: interestingMaps size) do: [:rowIndex | 
			((rowIndex + 1) to: interestingMaps size) do: [:colIndex |
				| dep |
				dep := MJFAMIXDerivedDependency new isDirected: false.
				dep source: (interestingMaps at: rowIndex).
				dep target: (interestingMaps at: colIndex).
				dep rationale: 'Connection derived from connections among source code elements.'.
				
				(interestingMaps at: rowIndex) addOutgoingDerivedDependency: dep.
				(interestingMaps at: colIndex) addIncomingDerivedDependency: dep.
				self mooseModel withoutAnnounceAdd: dep]]].
]

{ #category : #accessing }
MJFAMIXTableGroup >> ranked [
	^(((PageRank new
	referenced: [:element |
		(element isMemberOf: MJFAMIXTable) ifTrue: [ element mappedNamedEntities] ifFalse: [
		(element isMemberOf: FAMIXClass) ifTrue: [ element clientClasses] ifFalse: [#()]]
		];
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea ])
]

{ #category : #views }
MJFAMIXTableGroup >> viewDBTables [
	"<menuItem: 'View DB Tables' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewDBTablesOn: view.
	view open.
	
]

{ #category : #views }
MJFAMIXTableGroup >> viewDBTablesOn: view [
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view node: #tables forIt: [ 
		(self sorted: [:a :b | a name < b name ])  do: [:table | 
				table viewDBTableOn: view.].
			view gridLayout].
]

{ #category : #views }
MJFAMIXTableGroup >> viewTableRank [
	<menuItem: 'Table Rank' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTableRankOn: view.
	^ view openWithStatusbar title: 'Table Rank'
]

{ #category : #views }
MJFAMIXTableGroup >> viewTableRankOn: view [ 
	| objects |
	
	objects := self ranked.
	
	view shape label
		text: [:each | each key name , (each value integerPart asString , '.' , each value fractionPart asString asString sliceFrom: 1 to: 3 )].	
	view nodes: objects.
	
	view bottomFlowLayout maxWidth: 600
]

{ #category : #views }
MJFAMIXTableGroup >> viewTables [
	<menuItem: 'View Tables' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #views }
MJFAMIXTableGroup >> viewTablesFKs [
	<menuItem: 'View Tables with FK Relations' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesFKsOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #views }
MJFAMIXTableGroup >> viewTablesFKsOn: view [
	
	view shape tableShape.
	view interaction nodraggable. 
	view interaction menuMorphBlock: [:each | each mooseMenuMorph ].  
	view nodes: self.

	view interaction nodraggable.
	view shape line color: Color lightGray.
	"view edges: self mooseModel allFKAssociations from: [:each | each sourceTable]  to: [:each | each targetTable].

	view shape line color: Color transparent."
	view edges: self mooseModel allFKAssociations from: [:each | each sourceColumn ownerTable ]  to: [:each | each targetColumn ownerTable].
	
	view horizontalTreeLayout  horizontalGap: 150.
]

{ #category : #views }
MJFAMIXTableGroup >> viewTablesOn: view [
	
	self do: [:table |
		table viewTableOn: view].
	view gridLayout.
]

{ #category : #views }
MJFAMIXTableGroup >> viewUMLTablesWithEJBeans [
	"<menuItem: 'Tables with Entity Beans UML class diagram' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesWithEJBeansOn: view.
	view open.
	
]

{ #category : #views }
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
