Class {
	#name : #MJFAMIXDerivedDependency,
	#superclass : #MJAssociation,
	#instVars : [
		'source',
		'target'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> from [

	^ self source
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> initialize [
	super initialize.
	
	source := nil.
	target := nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> source [
	<MSEProperty: #source type: #FAMIXNamedEntity opposite: #outgoingDerivedDependency>
	<MSEComment: 'Source named entity of the derive dependency. from-side of the association'>
	
	^source
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> source: aNamedEntity [
	source := FMMultivalueLink on: self
					update: #outgoingDerivedDependency
					from: self source
					to: aNamedEntity
]

{ #category : #accessing }
MJFAMIXDerivedDependency >> target [
	<MSEProperty: #target type: #FAMIXNamedEntity opposite: #incomingDerivedDependency>
	<MSEComment: 'Target named entity of the derive dependency. to-side of the association'>
	
	^target
]

{ #category : #accessing }
MJFAMIXDerivedDependency >> target: aNamedEntity [
	target := FMMultivalueLink on: self
					update: #incomingDerivedDependency
					from: self target
					to: aNamedEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> to [

	^ self target
]
