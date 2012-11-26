Class {
	#name : #MEEArchitecturalComponent,
	#superclass : #MEEArchitecturalEntity,
	#instVars : [
		'elements',
		'containedElements'
	],
	#category : #'Moose-JEE-Architecture'
}

{ #category : #'instance creation' }
MEEArchitecturalComponent class >> named: aString [ 
	^self new name: aString
]

{ #category : #accessing }
MEEArchitecturalComponent >> acceptStrategy: aLayeringStrategy [
	^self subclassResponsibility
]

{ #category : #accessing }
MEEArchitecturalComponent >> addContainedElement: aBAContainment [
	self containedElements add: aBAContainment
]

{ #category : #accessing }
MEEArchitecturalComponent >> clearContainedElements [

	containedElements := FMMultivalueLink on: self opposite: #containerComponent:.
	
]

{ #category : #accessing }
MEEArchitecturalComponent >> containedElements [
	<MSEProperty: #containedElements type: #MEEContainment opposite: #containerComponent> <multivalued> <derived>
	<MSEComment: 'Containment relationship for types.'>
	
	^containedElements
]

{ #category : #initialization }
MEEArchitecturalComponent >> initialize [
	super initialize.
	
	elements := Set new.
	containedElements := FMMultivalueLink on: self opposite: #containerComponent:.
	
	^self
]

{ #category : #initialization }
MEEArchitecturalComponent >> isGlobal [
	^false
]

{ #category : #initialization }
MEEArchitecturalComponent >> isLocal [
	^false
]
