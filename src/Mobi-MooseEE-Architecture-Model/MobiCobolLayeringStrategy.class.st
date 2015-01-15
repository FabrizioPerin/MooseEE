Class {
	#name : #MobiCobolLayeringStrategy,
	#superclass : #MJLayeringStrategy,
	#instVars : [
		'layers'
	],
	#category : #'Mobi-MooseEE-Architecture-Model'
}

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> addLayersConnectionsToTheModel [

	(1 to: layers size) do: [ :index |
		(index + 1) > layers size 
			ifFalse: [ 
				(layers at: index) lowerLevel: (layers at: (index + 1)) ]  ]
	
]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> instanciateLayers [
	
	layers := OrderedCollection new.
	
	"The layers must be added to this collection following the order in which they are logically organized"
	layers add: ( MJFAMIXPresentationLayer new acceptStrategy: self ).
	layers add: ( MJFAMIXServiceLayer new acceptStrategy: self ).
	layers add: ( MJFAMIXLogicLayer new acceptStrategy: self ).
	layers add: ( MobiDataAccessorsLayer new acceptStrategy: self ).
	layers add: ( MJFAMIXDataLayer new acceptStrategy: self ).
	
	self addLayersConnectionsToTheModel.
]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> populateDataAccessorsLayer: aLayerInstance [

	aLayerInstance containedElements addAll: ( model allCobolLists reject: [:cobol | cobol accessedRelationalEntities isEmpty ] ).
	
	aLayerInstance rationale: 'This layer contains all the cobol lists that access in anyway the database'.
	
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> populateDataLayer: aLayerInstance [

	aLayerInstance containedElements addAll: model allTables.
	aLayerInstance containedElements addAll: model allViews.
	
	aLayerInstance rationale: 'This layer contains all the database tables and views in this model'.
	
	model add: aLayerInstance.

]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> populateLogicLayer: aLayerInstance [

	aLayerInstance containedElements addAll: ( model allCobolLists 
														select: [:cobol | 
															(cobol accessedRelationalEntities isEmpty)
																and: [ cobol incomingCalls isEmpty not ] ] ).
	
	aLayerInstance rationale: 'This layer contains all the cobol lists that are not belong the data accessors layer or the service layer'.	
		
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> populatePresentationLayer: aLayerInstance [

"	aLayerInstance containedElements addAll: (model allClasses select: [:class | class methods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] )."
	
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MobiCobolLayeringStrategy >> populateServiceLayer: aLayerInstance [

	aLayerInstance containedElements addAll: (( model allCobolLists select: [ :cobol | cobol incomingCalls isEmpty ] ) reject: [ :cobol | cobol outgoingCalls isEmpty ] ).
	
	model add: aLayerInstance
]
