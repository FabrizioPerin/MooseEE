Class {
	#name : #MJFAMIXTablesGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #meta }
MJFAMIXTablesGroup class >> annotation [

	<MSEClass: #MJFAMIXTablesGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTables [
	<menuItem: 'Tables UML class diagram like' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTablesOn: view [
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view node: #tables forIt: [ 
		(self sorted: [:a :b | a name < b name ])  do: [:table | 
				table viewUMLTableOn: view.].
			view gridLayout].
]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTablesWithEJBeans [
	<menuItem: 'Tables with Entity Beans UML class diagram' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesWithEJBeansOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTablesWithEJBeansOn: view [
	
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
						table mappedNamedEntities first implementedEntityBean viewUMLOfImplementorsOn: view.
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
