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
	
	view shape umlClassDiagramLikeForTable. 
	view interaction menu: #mooseMenuMorph.
	view nodes: self entities.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTablesWithEJBeans [
	<menuItem: 'Tables and Entity Bean UML class diagram' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesWithEJBeansOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTablesGroup >> viewUMLTablesWithEJBeansOn: view [
	
	| lonelyTables |
	
	lonelyTables := self reject: [:each | each inUse].
	
	view interaction nodraggable.
	view shape rectangle withoutBorder.
	view node: #notLonelyTables forIt: [
	
		"Show Entity Beans"
		view interaction menu: #mooseMenuMorph.
		view interaction nodraggable.
		view nodes: (((self entities first mooseModel allEntityBeans) collect: [:each | each implementationClass]) select: [:each | each accessATable]).
		
		"Show used tables"
		view shape umlClassDiagramLikeForTable. 
		view interaction menu: #mooseMenuMorph.
		view interaction nodraggable.
		view nodes: (self entities difference: lonelyTables entities).
	
		view shape line.
		view edges: self entities first mooseModel allMaps from: #mapSource to: #mapTarget.
	
		view treeLayout.
	].

	lonelyTables notEmpty ifTrue: [
		view shape rectangle withoutBorder.
		view interaction nodraggable.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Tables' ].
		view node: lonelyTables forIt: [ 
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view interaction nodraggable.
			view nodes: lonelyTables using: view shape umlClassDiagramLikeForTable.
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

]
