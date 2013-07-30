Class {
	#name : #MJFAMIXPHPParameter,
	#superclass : #FAMIXParameter,
	#instVars : [
		'defaultValue'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPParameter class >> annotation [
	<MSEClass: #MJFAMIXPHPParameter super: #FAMIXParameter>
	<package: #'Moose-JEE-PHP-Model'>
]

{ #category : #accessing }
MJFAMIXPHPParameter >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
MJFAMIXPHPParameter >> defaultValue: aLiteralOrArray [
	defaultValue := aLiteralOrArray.
]

{ #category : #testing }
MJFAMIXPHPParameter >> hasDefault [
	^ defaultValue notNil.
]
