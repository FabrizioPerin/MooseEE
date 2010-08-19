Class {
	#name : #MJSQLRelationalElements,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Moose-JEE-SQL'
}

{ #category : #accessing }
MJSQLRelationalElements >> name [

	^name
	
]

{ #category : #initialization }
MJSQLRelationalElements >> name: aString [

	name := aString.
	
]
