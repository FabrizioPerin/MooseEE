Class {
	#name : #MJFAMIXTablesGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
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
	
	| builder lonelyTables |
	
	lonelyTables := self reject: [:each | each inUse].
	
	view node: #try forIt:[
	view shape rectangle withoutBorder.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view interaction popupText: [:group | 'Used Tables' ].
	
	view node: #notLonelyTables forIt: [
	
		"Show Entity Beans"
		builder := MOFormsBuilder new.
		builder column; fill.
		builder row; fill; row; fill; row; fill.
		builder x: 1 y: 1 add: (MORectangleShape new text: [ :cls | 
			cls name ]; fontSize: 10; textAlignment: #center; textHorizontalPadding: 2; textVerticalPadding: 2).
		builder x: 1 y: 2 add: (MORectangleShape new text: [ :cls | 
			cls methods asArray inject: '' into: [ :sum :el | sum , el name , String cr ] ]; fontSize: 6; textAlignment: #left; textVerticalPadding: 2).
		builder x: 1 y: 3 add: (MORectangleShape new ).
		view shape: builder shape.
		view interaction menu: #mooseMenuMorph.
		view nodes: ((self entities first mooseModel allEntityBeans) collect: [:each | each implementationClass]).
		
		"Show used tables"
		view shape umlClassDiagramLikeForTable. 
		view interaction menu: #mooseMenuMorph.
		view nodes: (self entities difference: lonelyTables entities).
	
		view shape line.
		view edges: self entities first mooseModel allMaps from: #mapSource to: #mapTarget.
	
		view treeLayout.
	].
	view flowLayout maxWidth: 300.
	].

	lonelyTables notEmpty ifTrue: [
		view shape rectangle withoutBorder.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Tables' ].
		view node: lonelyTables forIt: [ 
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view nodes: lonelyTables using: view shape umlClassDiagramLikeForTable.
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

	
]
