Class {
	#name : #MEEArchitecturalEntity,
	#superclass : #FAMIXEntity,
	#instVars : [
		'name'
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
MEEArchitecturalEntity >> name [
	<MSEProperty: #name type: #String>
	<MSEComment: 'Basic name of the entity, not full reference.'>
	
	^name
]

{ #category : #accessing }
MEEArchitecturalEntity >> name: aString [
	name := aString
]
