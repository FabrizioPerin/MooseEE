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
MJFAMIXTable >> tableShape [
	| builder index |
 
	index := self columns size.
		
	builder := MOFormsBuilder new.
	builder column; pref.
	builder row; pref.
	index timesRepeat: [ builder row; left. ].
	
	builder 
		x: 1 
		y: 1 
		add: (MORectangleShape new withoutBorder
				text: [ :table | table name];
				fontSize: 10;
				fillColor: Color transparent;
				textAlignment: #center;
				textPadding: 1).

	(1 to: index) asArray do: [:count |
		builder 
			x: 1 
			y: (count + 1)
			add: (self columns at: count) columnShape.].
	
	^builder shape
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
	view open
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewTableOn: view [

	view shape rectangle.
	view interaction nodraggable.
	view node: self forIt: [
		view shape: self tableShape.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText.
		view node: self.]
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewUMLTable [
	<menuItem: 'Table UML class diagram like' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewUMLTableOn: view.
	view open
]

{ #category : #'as yet unclassified' }
MJFAMIXTable >> viewUMLTableOn: view [
	view shape umlClassDiagramLikeForTable.
	view interaction popupText.
	view node: self.
]
