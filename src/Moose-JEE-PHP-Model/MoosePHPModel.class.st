Class {
	#name : #MoosePHPModel,
	#superclass : #MooseModel,
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MoosePHPModel class >> asMooseDescription [
	^self meta descriptionOf: self theNonMetaClass 
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allAnnotationTypes [
	^ self allResolvedAnnotationTypes
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allAttributes [
	^ self allWithType: MJFAMIXPHPAttribute
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allClasses [
	^ (self allWithSubTypesOf: MJFAMIXPHPClass ofGroupClass: FAMIXClassGroup)
		select: [ :entity | entity isAnnotation not or: [ entity isStub not ] ]
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allInterfaces [
	<navigation:'All interfaces'>
	^ self allClasses select: [:item | item isInterface ]
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allMethods [
	^ self allWithSubTypesOf: MJFAMIXPHPMethod ofGroupClass:  FAMIXMethodGroup
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allNamespaces [
	^ self allWithType: MJFAMIXPHPNamespace ofGroupClass: FAMIXNamespaceGroup
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allPossibleAnnotationTypes [
	<navigation:'All possible annotation types'>
	^ self allWithSubTypesOf: MJFAMIXPHPAnnotation ofGroupClass:  FAMIXAnnotationTypeGroup
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allResolvedAnnotationTypes [
	^ self allPossibleAnnotationTypes select: [:node | node isStub not ]
]
