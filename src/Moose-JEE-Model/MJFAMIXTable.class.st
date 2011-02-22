Class {
	#name : #MJFAMIXTable,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'columns',
		'dataBase',
		'ownerDataBase',
		'nameAsRegExIgCa',
		'nameAsRegEx',
		'used'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXTable class >> annotation [
	<MSEClass: #Table super: #MJFAMIXRelationalEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #accessing }
MJFAMIXTable >> addColumn: aFAMIXTablesColumn [

	self columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
MJFAMIXTable >> columns [
	^columns
]

{ #category : #accessing }
MJFAMIXTable >> columns: aOrderedCollection [

	columns := aOrderedCollection.
]

{ #category : #accessing }
MJFAMIXTable >> inUse [
	used isNil 
		ifTrue: [self inUse: self mappedNamedEntities isEmpty not].
	^used
]

{ #category : #accessing }
MJFAMIXTable >> inUse: aBooleanOrNil [
	used := aBooleanOrNil.
]

{ #category : #initialization }
MJFAMIXTable >> initialize [

	super initialize.
	columns := OrderedCollection new.
	ownerDataBase := nil.
	nameAsRegExIgCa := nil.
	nameAsRegEx := nil.
]

{ #category : #accessing }
MJFAMIXTable >> nameAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [('.*', self name, '.*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #accessing }
MJFAMIXTable >> nameAsRegexIgnoringCase [
	^nameAsRegExIgCa isNil 
		ifTrue: [('.*', self name, '.*') asRegexIgnoringCase]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
MJFAMIXTable >> nameWithAnnotationAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [nameAsRegEx := ('.*@Table\(name = "',self name,'".*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #accessing }
MJFAMIXTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
MJFAMIXTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Table)'
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewDBTableOn: view [
	view shape DBTableShape.
	view interaction popupText.
	view node: self.
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewTable [
	<menuItem: 'Table' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableOn: view.
	view root applyLayout.
	view open
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewTableOn: view [

	view shape tableShape.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view interaction popupText.
	view node: self forIt: [
		view shape rectangle 
			withoutBorder; 
			text: [:col | col name];
			fontColor: [:col | 
				(col isPK notNil and:[col isPK]) 
				ifTrue: [Color blue] 
				ifFalse: [Color black]].
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText.
		view nodes: self columns.
		view verticalLineLayout. ].
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewTableUsage [
	<menuItem: 'Table''s used elements' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableUsageOn: view.
	view open
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewTableUsageOn: view [
	view shape umlClassDiagramLikeForTable.
	view interaction popupText.
	view node: self.
]
