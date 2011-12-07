Class {
	#name : #MJMapper,
	#superclass : #Object,
	#instVars : [
		'mappingStrategy'
	],
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #accessing }
MJMapper >> buildOn: aTargetModel [
]

{ #category : #strategies }
MJMapper >> mapColumnsOnMethodsAndAttributes [
	^self mappingStrategy: #MapColumnsOnMethodsAndAttributes new.
	
]

{ #category : #strategies }
MJMapper >> mapTablesOnClassesByName [
	^self mappingStrategy: MapTablesOnClassesByName new.
]

{ #category : #strategies }
MJMapper >> mapTablesOnClassesUsingAnnotations [
	^self mappingStrategy: MapTablesOnClassesUsingAnnotations new.
]

{ #category : #strategies }
MJMapper >> mapTablesOnInterfacesByName [
	^self mappingStrategy: MapTablesOnInterfacesByName new.
]

{ #category : #accessing }
MJMapper >> mappingStrategy [
	^ mappingStrategy
]

{ #category : #accessing }
MJMapper >> mappingStrategy: anObject [
	mappingStrategy := anObject
]
