Class {
	#name : #MEEEntity,
	#superclass : #FAMIXEntity,
	#instVars : [
		'name'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MEEEntity >> name [
	<MSEProperty: #name type: #String>
	<MSEComment: 'Basic name of the entity, not full reference.'>
	
	^name
]

{ #category : #'as yet unclassified' }
MEEEntity >> name: aString [
	name := aString
]
