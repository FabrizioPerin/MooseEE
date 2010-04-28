Class {
	#name : #MJFAMIXDataLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MJFAMIXDataLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll:  (aMooseModel allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] ).
	
]
