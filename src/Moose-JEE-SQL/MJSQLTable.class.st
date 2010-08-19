Class {
	#name : #MJSQLTable,
	#superclass : #MJSQLRelationalElements,
	#instVars : [
		'database',
		'attributes'
	],
	#category : #'Moose-JEE-SQL'
}

{ #category : #'initialize-release' }
MJSQLTable class >> name: aString ownedBy: aDatabase [

	^self new name: aString; database: aDatabase; yourself.
	
]

{ #category : #initialization }
MJSQLTable >> addAttribute: anAttribute [
	attributes addLast: anAttribute 
]

{ #category : #initialization }
MJSQLTable >> attributes [
	^attributes 
]

{ #category : #initialization }
MJSQLTable >> createRelationalElementWith: aDB [
	
	| tab |
	
	tab := MJFAMIXTable new.
	tab name: self name.
	tab ownerDataBase: aDB.
	tab columns: (self attributes collect: [:each | each createRelationalElementWith: self]).   
	
	^tab
]

{ #category : #initialization }
MJSQLTable >> database [
	^database 
]

{ #category : #initialization }
MJSQLTable >> database: aDatabase [

	database := aDatabase.
	^aDatabase 
]

{ #category : #initialization }
MJSQLTable >> initialize [

	super initialize.
	database := nil.
	attributes := OrderedCollection new.
]
