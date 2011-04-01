Class {
	#name : #MJFAMIXTable,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'columns',
		'dataBase',
		'ownerDataBase',
		'nameAsRegExIgCa',
		'nameAsRegEx',
		'used',
		'tableConstraints'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXTable class >> annotation [
	<MSEClass: #Table super: #MJFAMIXRelationalEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #testing }
MJFAMIXTable >> FKColumns [
	^self columns select: [:column | column isFK notNil and: [column isFK]].  
]

{ #category : #testing }
MJFAMIXTable >> PKColumns [
	^self columns select: [:column | column isPK notNil and: [column isPK]].  
]

{ #category : #accessing }
MJFAMIXTable >> addColumn: aFAMIXTablesColumn [

	self columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
MJFAMIXTable >> addConstraint: aMJFAMIXSQLConstraint [
	tableConstraints addLast: aMJFAMIXSQLConstraint
]

{ #category : #accessing }
MJFAMIXTable >> columns [
	<navigation: #columns>
	^columns
]

{ #category : #accessing }
MJFAMIXTable >> columns: aOrderedCollection [

	columns := aOrderedCollection.
]

{ #category : #accessing }
MJFAMIXTable >> constraints [
	^ tableConstraints
]

{ #category : #testing }
MJFAMIXTable >> hasComposePK [
	^self PKColumns size > 1
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
	tableConstraints := OrderedCollection new.
]

{ #category : #accessing }
MJFAMIXTable >> name [
	^name
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

{ #category : #accessing }
MJFAMIXTable >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Table)'
]

{ #category : #visualizations }
MJFAMIXTable >> viewDBTableOn: view [
	view shape DBTableShape.
	view interaction popupText.
	view node: self.
]

{ #category : #visualizations }
MJFAMIXTable >> viewTable [
	<menuItem: 'Table' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableOn: view.
	view root applyLayout.
	view open
]

{ #category : #visualizations }
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

{ #category : #visualizations }
MJFAMIXTable >> viewTableUsage [
	<menuItem: 'Table''s used elements' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableUsageOn: view.
	view open
]

{ #category : #visualizations }
MJFAMIXTable >> viewTableUsageOn: view [
	view shape umlClassDiagramLikeForTable.
	view interaction popupText.
	view node: self.
]

{ #category : #accessing }
MJFAMIXTable >> withDeepReferencedByTables [

	| cursor result tablesReferenceTheCurentOne |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		tablesReferenceTheCurentOne := (( result at: cursor ) columns flatCollect: [:each | each referencedBy]) collect: [:assoc | assoc sourceColumn ownerTable].
		result addAll: ( tablesReferenceTheCurentOne reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]

{ #category : #accessing }
MJFAMIXTable >> withDeepReferencesTables [

	| cursor result tablesReferencedByTheCurrent |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		tablesReferencedByTheCurrent := ((result at: cursor) columns flatCollect: [:each | each references]) collect: [:each | each targetColumn ownerTable].
		result addAll: ( tablesReferencedByTheCurrent reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]
