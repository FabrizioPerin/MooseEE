Class {
	#name : #MJSQLDataBase,
	#superclass : #MJSQLRelationalElements,
	#instVars : [
		'tables'
	],
	#category : #'Moose-JEE-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLDataBase class >> name: aString [

	^self new name: aString
]

{ #category : #initialization }
MJSQLDataBase >> addTable: aTable [
	tables addLast: aTable 
]

{ #category : #initialization }
MJSQLDataBase >> createRelationalElements [
	
	| dB |
	
	dB := MJFAMIXDataBase new.
	dB name: self name.
	dB tables: (self tables collect: [:each | each createRelationalElementWith: dB]).
		
	^dB
]

{ #category : #initialization }
MJSQLDataBase >> initialize [

	super initialize.
	tables := OrderedCollection new.
]

{ #category : #initialization }
MJSQLDataBase >> tables [
	^tables 
]
