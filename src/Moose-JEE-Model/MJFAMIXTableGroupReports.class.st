Class {
	#name : #MJFAMIXTableGroupReports,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Model-Reports'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> browser [
  | browser |
  browser := GLMTabulator new.
  browser column: #map.
  browser transmit to: #map; andShow: [:a | 
    a mondrian
      title: 'FK Relations';
      painting: [:view :tables | 
        self viewFKRelationsAmong: tables On: view]].
  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> computeResult [
  ^ self model allTables.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> explanation [ 
  ^ 'Analyses on a table group '
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> label [ 
  ^ 'Foreign Key recovery'
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> viewCell: aMatrix on: view [
  view shape label 
    text: [:each | each]; 
    fontColor: [:each | each isNumber
						ifTrue: [(each < 4)
								ifTrue: [Color blue]
								ifFalse: [Color gray]]].
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> viewFKRelationsAmong: aTableGroup On: aView [

| mooseModel tuples left right grouped map |
mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
tuples := mooseModel allTables computeLevenshteinDistancesAmongTheFieldsUsingArrays select: [:each | each third < 3].
aView nodes: mooseModel allTables forEach: [:each |
	aView shape rectangle borderWidth: 0; text: [:col | col name].
	aView nodes: each columns.
	aView horizontalTreeLayout ].
aView shape line width: #third.
aView edges: tuples from: #first to: #second.
aView shape line color: Color transparent.
aView edges: tuples from: [:each | each first ownerTable] to: [:each | each second ownerTable].
aView horizontalTreeLayout.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> viewMatrix: aMatrix on: view [
	view shape rectangle.
	view interaction nodraggable.
	view node: 'matrix' forIt: [
		view shape rectangle.
		view interaction nodraggable.
		view nodes: aMatrix asArray forEach: [:node | 
			self viewCell: node on: view.
			view gridLayout]].
	view gridLayout.
]
