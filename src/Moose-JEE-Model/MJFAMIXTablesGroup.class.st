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
	<menuItem: 'Tables UML class diagram like' category: 'Visualize'> 

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
