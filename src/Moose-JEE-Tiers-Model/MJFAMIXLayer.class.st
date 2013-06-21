Class {
	#name : #MJFAMIXLayer,
	#superclass : #MEEArchitecturalEntity,
	#instVars : [
		'rationale',
		'layerStrategyName',
		'containedElements',
		'upperLevel',
		'lowerLevel'
	],
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLayer class >> annotation [
	<MSEClass: #MJFAMIXLayer super: #MEEArchitecturalEntity>
	<package: #'Moose-JEE-Tiers-Model'>
	
	^self 
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> acceptStrategy: aLayeringStrategy [
	^self subclassResponsibility
]

{ #category : #accessing }
MJFAMIXLayer >> addContainedElement: aFAMIXEntity [
	self containedElements add: aFAMIXEntity
]

{ #category : #accessing }
MJFAMIXLayer >> belongsTo [ 
	^''
]

{ #category : #accessing }
MJFAMIXLayer >> containedElements [
	<MSEProperty: #containedElements type: #FAMIXEntity opposite: #containerLayer:> <multivalued> <derived>
	<MSEComment: 'List of elements contained in this layer.'>
	^containedElements
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> fileOutContainedClasses [
	<menuItem: 'File out contained classes list' category: 'JEAs Utilities'>
	| stream name |
	
	name := self name.
	name := name removeSuffix: ' Layer'.
	
	stream := MultiByteFileStream forceNewFileNamed: (name , '.out').
	
	self containedElements do: [:class |
		stream nextPutAll: (class mooseName asString , String cr asString)].
	stream close.
]

{ #category : #initialization }
MJFAMIXLayer >> initialize [ 
	super initialize.
	containedElements := FMMultivalueLink on: self opposite: #containerLayer:.
	upperLevel := nil.
	lowerLevel := nil.
	^self
]

{ #category : #accessing }
MJFAMIXLayer >> isBusinessLayer [
	^false
]

{ #category : #accessing }
MJFAMIXLayer >> isDataLayer [
	^false
]

{ #category : #accessing }
MJFAMIXLayer >> isLogicLayer [
	^false
]

{ #category : #accessing }
MJFAMIXLayer >> isPresentationLayer [
	^false
]

{ #category : #accessing }
MJFAMIXLayer >> isServiceLayer [
	^false
]

{ #category : #accessing }
MJFAMIXLayer >> layerStrategyName [
	^ layerStrategyName
]

{ #category : #accessing }
MJFAMIXLayer >> layerStrategyName: anObject [
	layerStrategyName := anObject
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> lowerLevel [
	<MSEProperty: #lowerLevel type: #MJFAMIXLayer opposite: #upperLevel>
	<MSEComment: 'Pointer to the layer beneath this.'>
	
	^lowerLevel
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> lowerLevel: aFamixLayer [
	(lowerLevel ~= aFamixLayer) ifTrue: [ 
		| old |
		old := lowerLevel.
		lowerLevel := aFamixLayer.
		old notNil ifTrue: [ old upperLevel: nil ].
		aFamixLayer notNil ifTrue: [ aFamixLayer upperLevel: self ]]
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> populate: aMooseModel [

	| layer |

	layer := self selectClassesFrom: aMooseModel.
	aMooseModel add: layer.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> printOn: aStream [
	
	self name isNil ifFalse: [ aStream nextPutAll: self name ].
	
	aStream nextPutAll: ' (Layer)'
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> rationale [
	^rationale
]

{ #category : #accessing }
MJFAMIXLayer >> rationale: anObject [
	rationale := anObject
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> selectClassesFrom: aMooseModel [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> upperLevel [
	<MSEProperty: #upperLevel type: #MJFAMIXLayer opposite: #lowerLevel>
	<MSEComment: 'Pointer to the layer above this.'>
	
	^upperLevel
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> upperLevel: aFamixLayer [
	(upperLevel ~= aFamixLayer) ifTrue: [ 
		| old |
		old := upperLevel.
		upperLevel := aFamixLayer.

		old notNil ifTrue: [ old lowerLevel: nil ].
		aFamixLayer notNil ifTrue: [ aFamixLayer lowerLevel: self ]]
]
