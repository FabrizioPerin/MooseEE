Class {
	#name : #MJFAMIXDataLayer,
	#superclass : #MJFAMIXLayer,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXDataLayer class >> annotation [
	<MSEClass: #MJFAMIXDataLayer super: #MJFAMIXLayer>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXDataLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populateDataLayer: self.
]

{ #category : #'as yet unclassified' }
MJFAMIXDataLayer >> name [
	^'Data Layer'
]

{ #category : #'as yet unclassified' }
MJFAMIXDataLayer >> selectClassesFrom: aMooseModel [

	containedClasses addAll:  (aMooseModel allClasses select: [:class | 
					(class doesImplements: #Serializable)  or: [ 
					class  methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ] ] ).
	
]
