Class {
	#name : #MJFAMIXEntityBeanGroup,
	#superclass : #MEEAbstractGroup,
	#category : #'Moose-JEE-EJB-Model'
}

{ #category : #meta }
MJFAMIXEntityBeanGroup class >> annotation [

	<MSEClass: #MJFAMIXEntityBeanGroup super: #MEEAbstractGroup>
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
	
	view shape rectangle withoutBorder fillColor: Color transparent.
	view interaction nodraggable.
	view node: #entityBeans forIt: [ 
			(self sorted: [:a :b | a implementationClass name < b implementationClass name ]) do: [:entity | 
				entity viewUMLOfImplementorOn: view.].
			view gridLayout].
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
	
	| lonelyBeans notLonelyBeans |
	
	lonelyBeans := (self reject: [:each | each implementationClass accessATable ]) sorted: [:a :b | a implementationClass name < b implementationClass name ].
	notLonelyBeans := (self select: [:each | each implementationClass accessATable]) sorted: [:a :b | a implementationClass name < b implementationClass name ].

	notLonelyBeans isEmpty ifFalse: [
		view shape rectangle withoutBorder fillColor: Color transparent.
		view interaction nodraggable.
		view node: #notLonelyBeans forIt: [ 
			notLonelyBeans do: [:entity | 
				entity viewUMLOfImplementorOn: view.
				entity implementationClass mappedRelationalEntities first viewTableUsageOn: view.].
			
			view shape line.
			view edges: self mooseModel allMaps from: #mapSource to: #mapTarget.
			view treeLayout.]].

	lonelyBeans isEmpty ifFalse: [
		view nodes: (lonelyBeans collect: [:each | each implementationClass ]) using: view shape umlClassWithAll.]
	
]
