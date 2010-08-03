Class {
	#name : #MJFAMIXEntityBeanGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #meta }
MJFAMIXEntityBeanGroup class >> annotation [

	<MSEClass: #MJFAMIXEntityBeanGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'JEAs Visualizations'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.

]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewUMLOfImplementors [
	<menuItem: 'UML class diagram of the implementors' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLOfImplementorsOn: view.
	view open.
]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewUMLOfImplementorsOn: view [
	
	view shape umlClassWithAll.
	view interaction menu: #mooseMenuMorph.
	view nodes: ((self collect: [:each | each implementationClass]) sorted: [:a :b | a name < b name ]).
	view gridLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewUMLOfImplementorsWithTables [
	<menuItem: 'UML class diagram of the implementors with Tables' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLOfImplementorsWithTablesOn: view.
	view open.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewUMLOfImplementorsWithTablesOn: view [
	
	| lonelyBeansClasses notLonelyBeansClasses |
	
	lonelyBeansClasses := (self collect: [:each | each implementationClass]) reject: [:each | each accessATable].
	notLonelyBeansClasses := (self collect: [:each | each implementationClass]) difference: lonelyBeansClasses.
	
	view interaction nodraggable.
	view shape rectangle withoutBorder.
	view node: #notLonelyBeans forIt: [
	
		"Show Entity Beans"
		view shape umlClassWithAttributes.
		view interaction menu: #mooseMenuMorph.
		view interaction nodraggable.
		view nodes: (notLonelyBeansClasses sorted: [:a :b | a name < b name ]).
		
		"Show used tables"
		view shape umlClassDiagramLikeForTable. 
		view interaction menu: #mooseMenuMorph.
		view interaction nodraggable.
		view nodes: (notLonelyBeansClasses flatCollect: [:each | each mappedRelationalEntities]) entities.
	
		view shape line.
		view edges: self entities first mooseModel allMaps from: #mapSource to: #mapTarget.
	
		view treeLayout.
	].

	lonelyBeansClasses notEmpty ifTrue: [
		view shape rectangle withoutBorder.
		view interaction nodraggable.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Beans' ].
		view node: lonelyBeansClasses forIt: [ 
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view interaction nodraggable.
			view nodes: lonelyBeansClasses using: view shape umlClassWithAttributes.
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

]
