Class {
	#name : #MEEComponentAssociation,
	#superclass : #MEEArchitecturalAssociation,
	#instVars : [
		'source',
		'target',
		'directed',
		'rationale',
		'associations',
		'isAccess'
	],
	#category : #'Moose-JEE-Architecture'
}

{ #category : #'as yet unclassified' }
MEEComponentAssociation class >> annotation [
	<MSEClass: #MEEComponentAssociation super: #MJAssociation>
	<package: #'Babel-Model'>
	^self
]

{ #category : #accessing }
MEEComponentAssociation >> addAssociation: anAssociation [
	associations add: anAssociation
]

{ #category : #accessing }
MEEComponentAssociation >> associations [
	<navigation: 'Associations'>
	^ associations
]

{ #category : #accessing }
MEEComponentAssociation >> associations: aCollection [
	associations := aCollection
]

{ #category : #accessing }
MEEComponentAssociation >> from [
	^ self source
]

{ #category : #initialization }
MEEComponentAssociation >> initialize [
	super initialize.
	
	source := nil.
	target := nil.
	directed := false.
	rationale := ''.
	isAccess  := false.
]

{ #category : #accessing }
MEEComponentAssociation >> isDirected [
	"If false it means that the direction of the dependency does not count. If true it means that the direction is from the source to the target. Can be nil"
	^directed
]

{ #category : #accessing }
MEEComponentAssociation >> isDirected: aBoolean [
	directed := aBoolean.
]

{ #category : #printing }
MEEComponentAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from componentName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to componentName].
	aStream nextPutAll: ' (Component Association)'
]

{ #category : #accessing }
MEEComponentAssociation >> rationale [
	^rationale
]

{ #category : #accessing }
MEEComponentAssociation >> rationale: aString [
	rationale := aString.
]

{ #category : #accessing }
MEEComponentAssociation >> source [
	<MSEProperty: #source type: #MEEArchitecturalComponent opposite: #outgoingComponentAssociation>
	<MSEComment: 'Source component of the association. from-side of the association'>
	
	^source
]

{ #category : #accessing }
MEEComponentAssociation >> source: aComponent [
	source := FMMultivalueLink on: self
					update: #outgoingComponentAssociation
					from: self source
					to: aComponent
]

{ #category : #accessing }
MEEComponentAssociation >> target [
	<MSEProperty: #target type: #MEEArchitecturalComponent opposite: #incomingComponentAssociation>
	<MSEComment: 'Target component of the association. to-side of the association'>
	
	^target
]

{ #category : #accessing }
MEEComponentAssociation >> target: aComponent [
	target := FMMultivalueLink on: self
					update: #incomingComponentAssociation
					from: self target
					to: aComponent
]

{ #category : #accessing }
MEEComponentAssociation >> to [
	^ self target
]
