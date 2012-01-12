Class {
	#name : #MJMappingStrategy,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJMappingStrategy class >> on: aMooseModel [
	
	^self new initialize: aMooseModel.
]

{ #category : #'as yet unclassified' }
MJMappingStrategy >> buildMapsOn: aTargetModel [
	self subclassResponsibility.
]

{ #category : #toRemove }
MJMappingStrategy >> buildRelationsAmongDBTablesAndClasses [
	"<menuItem: 'Build Relations Among Tables And Classes' category: 'JEAs Importers'>"
	MapTablesOnClassesUsingAnnotations new buildMapsOn: targetModel.
]

{ #category : #toRemove }
MJMappingStrategy >> buildRelationsAmongTableColumnsAndMethodsAndAttributes [
	"<menuItem: 'Build Relations Among Columns And Methods' category: 'JEAs Importers'>"
	MapColumnsOnMethodsAndAttributes new buildMapsOn: targetModel.
]

{ #category : #toRemove }
MJMappingStrategy >> buildRelationsAmongTablesAndAllClassesByName [
	"<menuItem: 'Build Relations Among Tables And All Classes by name' category: 'JEAs Importers'>"
	MapTablesOnClassesByName new buildMapsOn: targetModel.
]

{ #category : #toRemove }
MJMappingStrategy >> buildRelationsAmongTablesAndInterfacesByName [
	"<menuItem: 'Build Relations Among Tables And Interfaces by name' category: 'JEAs Importers'>"
	MapTablesOnInterfacesByName new buildMapsOn: targetModel.
]

{ #category : #toRemove }
MJMappingStrategy >> initialize: aMooseModel [
	targetModel := aMooseModel.
	^self 
]
