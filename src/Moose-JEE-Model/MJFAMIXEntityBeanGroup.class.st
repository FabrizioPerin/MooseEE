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
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view nodes: (self sorted: [:a :b | a implementationClass name < b implementationClass name ]) forEach: [:entity | entity viewUMLOfImplementorsOn: view.].
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
	
	lonelyBeansClasses := (self reject: [:each | each implementationClass accessATable ]) sorted: [:a :b | a implementationClass name < b implementationClass name ].
	notLonelyBeansClasses := (self select: [:each | each implementationClass accessATable]) sorted: [:a :b | a implementationClass name < b implementationClass name ].
	
	notLonelyBeansClasses isEmpty ifFalse: [
		view interaction nodraggable.
		view shape rectangle withoutBorder.
		view node: #notLonelyBeans forIt: [
			"Show Entity Beans"
			view interaction nodraggable.
			view shape rectangle withoutBorder.
			view nodes: notLonelyBeansClasses forEach: [:entity | 
					entity viewUMLOfImplementorsOn: view.
					entity implementationClass mappedRelationalEntities first viewUMLTableOn: view.
					view shape line.
					view edges: entity mooseModel allMaps from: #mapSource to: #mapTarget.
					view treeLayout.].
			view gridLayout.]].

	lonelyBeansClasses isEmpty ifFalse: [
		view shape rectangle withoutBorder.
		view interaction nodraggable.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Beans' ].
		view node: lonelyBeansClasses forIt: [ 
			view shape rectangle withoutBorder.
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view interaction nodraggable.
			view nodes: lonelyBeansClasses forEach: [:entity | entity viewUMLOfImplementorsOn: view.].
			view flowLayout maxWidth: 600; gapSize: 2.
		]].
]
