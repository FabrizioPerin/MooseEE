Class {
	#name : #MJDPRole,
	#superclass : #MJDPEntity,
	#instVars : [
		'associatedClass',
		'patternName'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPRole class >> annotation [
	<MSEClass: #MJDPRole super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRole >> addAssociatedClass: aMJDPRoleAssociation [
	"This method contains a work around to make possible a 1to 1 relation with the MJDPRoleAssociation instance"
	"self associatedClass value: (OrderedCollection with: aMJDPRoleAssociation)."
	self associatedClass add: aMJDPRoleAssociation.
]

{ #category : #'as yet unclassified' }
MJDPRole >> associatedClass [
	<MSEProperty: #associatedClass type: #MJDPRoleAssociation opposite: #role> <multivalued> <derived>
	<MSEComment: 'Association with the source entity implementing this role.'>
	^associatedClass
]

{ #category : #'as yet unclassified' }
MJDPRole >> associatedClass: aMJDPRoleAssociation [
	"This method contains a work around to make possible a 1to 1 relation with the MJDPRoleAssociation instance"
	"self associatedClass value: (OrderedCollection with: aMJDPRoleAssociation)."
	self associatedClass value: aMJDPRoleAssociation.
]

{ #category : #'as yet unclassified' }
MJDPRole >> initialize [
	super initialize.
	
	associatedClass := FMMultivalueLink 
		on: self
		opposite: #role:.
	
	^self
]

{ #category : #accessing }
MJDPRole >> patternName [
	^ patternName
]

{ #category : #accessing }
MJDPRole >> patternName: anObject [
	patternName := anObject
]
