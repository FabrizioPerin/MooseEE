Class {
	#name : #MJDefautLayeringStrategy,
	#superclass : #MJLayeringStrategy,
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJDefautLayeringStrategy >> instanciateLayers [
	
	MJFAMIXPresentationLayer new acceptStrategy: self.
	MJFAMIXServiceLayer new acceptStrategy: self.
	MJFAMIXLogicLayer new acceptStrategy: self.
	MJFAMIXDataLayer new acceptStrategy: self.
]

{ #category : #'as yet unclassified' }
MJDefautLayeringStrategy >> populateDataLayer: aLayerInstance [

	
	aLayerInstance containedElements addAll:  (model allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] ).
	
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MJDefautLayeringStrategy >> populateLogicLayer: aLayerInstance [

	"aLayerInstance containedClasses addAll:  (model allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] )."
	
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MJDefautLayeringStrategy >> populatePresentationLayer: aLayerInstance [

	aLayerInstance containedElements addAll: (model allClasses select: [:class | class methods anySatisfy: [:method | (method name = #doPost) or: [ method name = #doGet ] ] ] ).
	
	model add: aLayerInstance.
	
]

{ #category : #'as yet unclassified' }
MJDefautLayeringStrategy >> populateServiceLayer: aLayerInstance [

	aLayerInstance containedElements addAll:( model allClasses select: [:class | class methods anySatisfy: [:method | method couldBeAnEntryPoint ] ]).
	aLayerInstance containedSessionBeans addAll: (model allSessionBeans collect: [:bean | bean implementationClass] ).
	
	model add: aLayerInstance.
	
]
