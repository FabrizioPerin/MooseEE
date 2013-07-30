Class {
	#name : #MJFAMIXPHPAttribute,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'defaultValue'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPAttribute class >> annotation [
	<MSEClass: #MJFAMIXPHPAttribute super: #FAMIXAttribute>
	<package: #'Moose-JEE-PHP-Model'>
]

{ #category : #accessing }
MJFAMIXPHPAttribute >> defaultValue [
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
