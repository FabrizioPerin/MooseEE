Class {
	#name : #MobiApplication,
	#superclass : #MEEArchitecturalComponent,
	#instVars : [
		'containedElements',
		'isBusiness'
	],
	#category : #'Mobi-MooseEE-Architecture-Model'
}

{ #category : #'as yet unclassified' }
MobiApplication class >> annotation [
	<MSEClass: #Application super: #MEEArchitecturalComponent>
	<package: #Mobi>
	^self
]

{ #category : #'as yet unclassified' }
MobiApplication >> acceptStrategy: aStrategy [
	aStrategy populateApplication: self.
]

{ #category : #accessing }
MobiApplication >> isBusiness [
	^ isBusiness
]

{ #category : #accessing }
MobiApplication >> isBusiness: anObject [
	isBusiness := anObject
]

{ #category : #accessing }
MobiApplication >> printOn: aStream [
	
	self name isNil ifFalse: [ aStream nextPutAll: self name ].
	
	"self isBusiness 
		ifTrue: [ aStream nextPutAll: ' (Business Application)' ]
		ifFalse: [ aStream nextPutAll: ' (Infrastructure Application)' ]"
	
	aStream nextPutAll: ' (Application)'
]

{ #category : #accessing }
MobiApplication >> viewContainedCobolAndTables [
	<menuItem: 'View Contained Cobol and tables' category: 'Mobi Visualizations'>
	| rawView view |
	
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	self viewContainedCobolAndTablesOn: view.
	^ view openWithStatusbar title: 'Cobol Rank'
]

{ #category : #accessing }
MobiApplication >> viewContainedCobolAndTablesOn: view [
	| allElements |
	
	allElements := ( self containedElements collect: #containedElement ) asSet.
	
	view nodes: ( allElements select: [ :each | each isMemberOf: FAMIXCobolList ] ) asMooseGroup.
	
	view shape rectangle withText: #name.
	view nodes: ( allElements select: [ :each | each isKindOf: FAMIXTable ] ) asMooseGroup.

	view edges: self mooseModel allDBAccesses asSet from: #accessorEntity to: #accessedEntity.
	view edges: self mooseModel allCobolCalls asSet from: #source to: #target.
	
	view dominanceTreeLayout 
]
