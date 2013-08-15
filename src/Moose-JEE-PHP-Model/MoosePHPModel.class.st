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
	^ self allWithSubTypesOf: MJFAMIXPHPAnnotation
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allAttributes [
	^ self allWithType: MJFAMIXPHPAttribute
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allClasses [
	^ self allWithSubTypesOf: FAMIXClass
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allMethods [
	^ self allWithType: MJFAMIXPHPMethod
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allResolvedAnnotationTypes [
	<navigation:'All resolved annotation types'>
	^ self allAnnotationTypes select: [:node | node isStub not]
]
