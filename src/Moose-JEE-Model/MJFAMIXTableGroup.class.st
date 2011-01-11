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
MJFAMIXTableGroup >> computeLevenshteinDistancesAmongTheFields [
	
	| aLevenshteinDistanceStrategy columns resultMatrix progr |
	
	columns := self flatCollect: [:table | table columns].
	
	"init matrix"
	resultMatrix := MalArrayMatrix new: (columns size+1). "+1 because at the first row and column i want to have the column name"
	
	(2 to: resultMatrix rowSize) asArray do: [:rowIndex |
			resultMatrix at: rowIndex and: 1 put: (columns at: (rowIndex - 1))].
	
	(2 to: resultMatrix columnSize) asArray do: [:colIndex |
			resultMatrix at: 1 and: colIndex put: (columns at: (colIndex - 1))].
	
	aLevenshteinDistanceStrategy := DudeLevenshteinDistanceStrategy threshold: 2.
	progr := 1.
	
	UIManager default
		displayProgress: 'Computing levenshtein distances'
		at: Sensor cursorPoint
		from: 1 
		to: (resultMatrix rowSize * resultMatrix columnSize)
		during: [ :bar | 
			(2 to: resultMatrix rowSize) asArray do: [:rowIndex |
				((rowIndex + 1) to: resultMatrix columnSize) asArray do: [:colIndex |
					resultMatrix 
						at: rowIndex 
						and: colIndex 
						put: (aLevenshteinDistanceStrategy levenshteinDistanceSource: (resultMatrix at: 1  and: rowIndex) name target: (resultMatrix at: colIndex and: 1) name).
						progr := progr+1.
						bar value: progr]]].
		
	^resultMatrix
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewDBTables [
	<menuItem: 'View DB Tables' category: 'JEAs Visualizations'> 

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
MJFAMIXTableGroup >> viewUMLTables [
	<menuItem: 'Tables UML class diagram like' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewUMLTablesOn: view [
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view node: #tables forIt: [ 
		(self sorted: [:a :b | a name < b name ])  do: [:table | 
				table viewUMLTableOn: view.].
			view gridLayout].
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroup >> viewUMLTablesWithEJBeans [
	<menuItem: 'Tables with Entity Beans UML class diagram' category: 'JEAs Visualizations'> 

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
						table viewUMLTableOn: view.
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
			view nodes: lonelyTables forEach: [:table | table viewUMLTableOn: view.]. "using: view shape umlClassDiagramLikeForTable."
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

]
