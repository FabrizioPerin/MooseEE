Class {
	#name : #MJRimaLayeringStrategy,
	#superclass : #MJDefautLayeringStrategy,
	#category : #'Moose-JEE-RimaCaseStudy'
}

{ #category : #'as yet unclassified' }
MJRimaLayeringStrategy >> populateDataLayer: aLayerInstance [
  
	| annotationTypeDataLayer |

	aLayerInstance containedClasses addAll:  (model allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] ).
			
	annotationTypeDataLayer := (model allAnnotationTypes select: [:each | each name = #dataLayer]).
	annotationTypeDataLayer ifNotEmpty: [aLayerInstance containedClasses addAll: annotationTypeDataLayer first annotatedEntities].
	
	model add: aLayerInstance. 
]