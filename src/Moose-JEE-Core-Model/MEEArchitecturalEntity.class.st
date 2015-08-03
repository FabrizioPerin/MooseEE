Class {
	#name : #MEEArchitecturalEntity,
	#superclass : #MEEEntity,
	#instVars : [
		'outgoingComponentAssociations',
		'incomingComponentAssociations'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MEEArchitecturalEntity class >> annotation [
	<MSEClass: #MEEArchitecturalEntity super: #FAMIXEntity>
	<package: #'Moose-JEE-Core-Model'>
	
	^self
]

{ #category : #accessing }
MEEArchitecturalEntity >> addIncomingComponentAssociation: aMEEComponentAssociation [
	incomingComponentAssociations add: aMEEComponentAssociation
]

{ #category : #accessing }
MEEArchitecturalEntity >> addOutgoingComponentAssociation: aMEEComponentAssociation [
	outgoingComponentAssociations add: aMEEComponentAssociation
]

{ #category : #accessing }
MEEArchitecturalEntity >> incomingComponentAssociations [
	<MSEProperty: #incomingComponentAssociations type: #MEEComponentAssociation opposite: #target> <multivalued>  <derived>
	<MSEComment: 'Association with another component'>
	
	^incomingComponentAssociations
]

{ #category : #accessing }
MEEArchitecturalEntity >> initialize [ 	
	super initialize.
	outgoingComponentAssociations := FMMultivalueLink on: self opposite: #source:.
	incomingComponentAssociations := FMMultivalueLink on: self opposite: #target:.
]

{ #category : #accessing }
MEEArchitecturalEntity >> outgoingComponentAssociations [
	<MSEProperty: #outgoingComponentAssociations type: #MEEComponentAssociation opposite: #source> <multivalued>  <derived>
	<MSEComment: 'Association with another component'>
	
	^outgoingComponentAssociations
]
