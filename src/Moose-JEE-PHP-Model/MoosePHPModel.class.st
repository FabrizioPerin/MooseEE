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
	^ self allWithType: MJFAMIXPHPAnnotation
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allAttributes [
	"<navigation: 'All Attributes'>"
	^ self allWithType: MJFAMIXPHPAttribute
]

{ #category : #'as yet unclassified' }
MoosePHPModel >> allMethods [
	"<navigation: 'All Methods'>"
	^ self allWithType: MJFAMIXPHPMethod
]
