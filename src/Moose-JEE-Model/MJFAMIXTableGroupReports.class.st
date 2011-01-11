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
      title: 'matrix';
      painting: [:view :aMatrix | 
        self viewMatrix: aMatrix on: view ]].
  ^ browser startOn: self result
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> computeResult [
  ^ self model allTables computeLevenshteinDistancesAmongTheFields.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> explanation [ 
  ^ 'Map of packages containing Facade classes'
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupReports >> label [ 
  ^ 'Facade watcher'
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
