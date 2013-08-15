Class {
	#name : #MJFAMIXPHPAttribute,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'defaultValue',
		'annotationAttributeInstances'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute class >> annotation [
	<MSEClass: #MJFAMIXPHPAttribute super: #FAMIXAttribute>
	<package: #'Moose-JEE-PHP-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute >> annotationAttributeInstances [
	<MSEProperty: #annotationAttributeInstances type: #FAMIXAnnotationInstanceAttribute opposite: #annotationTypeAttribute> <multivalued> <derived> 
	<MSEComment: 'A collection of AnnotationInstanceAttribute which hold the usages of this attribute in actual AnnotationInstances'>
	^ annotationAttributeInstances
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute >> annotationAttributeInstances: anObject [
	annotationAttributeInstances value: anObject
]

{ #category : #accessing }
MJFAMIXPHPAttribute >> defaultValue [
	<navigation: 'Default Value'>
	^ defaultValue
]

{ #category : #accessing }
MJFAMIXPHPAttribute >> defaultValue: aLiteralOrArray [
	defaultValue := aLiteralOrArray.
]

{ #category : #testing }
MJFAMIXPHPAttribute >> hasDefault [
	^ defaultValue notNil.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute >> initialize [
	super initialize.
	annotationAttributeInstances := FMMultivalueLink 
		on: self
		opposite: #annotationTypeAttribute:.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute >> parentAnnotationType [
	<MSEProperty: #parentAnnotationType type: #MJFAMIXPHPAnnotation> <derived> 
	<MSEComment: 'This is an alias pointing to the AnnotationType that defines this attribute'>
	^ self parentType
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute >> parentAnnotationType: anAnnotationType [
	self parentType: anAnnotationType
]
