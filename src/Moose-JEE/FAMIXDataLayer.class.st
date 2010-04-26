Class {
	#name : #FAMIXDataLayer,
	#superclass : #FAMIXLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXDataLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll:  (aMooseModel allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] ).
	
]
