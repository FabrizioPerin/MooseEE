Class {
	#name : #MJFAMIXPHPAnnotation,
	#superclass : #FAMIXClass,
	#instVars : [
		'instances'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> annotatedEntities [
	^ self instances collect: [:each | each annotatedEntity ]
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> annotatedEntitiesGroup [
	<navigation: 'Annotated entities'>
	^ self annotatedEntities asMooseGroup
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> belongsTo [
	^ container
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> container [
	<MSEProperty: #container type: #FAMIXContainerEntity opposite: #definedAnnotationTypes> 
	<MSEComment: 'Container in which an AnnotationType may reside'>
	^ container
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> container: aContainer [
	container := FMMultivalueLink on: self
					update: #definedAnnotationTypes
					from: self container
					to: aContainer
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> initialize [
	super initialize.
	instances := FMMultivalueLink 
		on: self
		opposite: #annotationType:.
	attributes := FMMultivalueLink 
		on: self
		opposite: #annotationType:.
	container := nil.

]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> instances [
	<MSEProperty: #instances type: #FAMIXAnnotationInstance opposite: #annotationType> <multivalued> <derived> 
	<MSEComment: 'Annotations of this type'>
	^ instances
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> instances: anAnnotationInstance [
	instances value: anAnnotationInstance
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> mooseIcon [ 
	^ MooseIcons famixAnnotationType
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPAnnotation >> mooseNameOn: aStream [ 
	| parent |
	parent := self container.
	parent ifNotNil: 
		[ 
			parent mooseNameOn: aStream.
			aStream
				nextPut: $:;
				nextPut: $: ].
	self name ifNotNil: [aStream nextPutAll: self name]
]
