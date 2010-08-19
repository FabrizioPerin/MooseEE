Class {
	#name : #MJSQLAttributes,
	#superclass : #MJSQLRelationalElements,
	#instVars : [
		'table',
		'type'
	],
	#category : #'Moose-JEE-SQL'
}

{ #category : #'initialize-release' }
MJSQLAttributes class >> name: aString ownedBy: aTable [

	| attribute |
	
	attribute := self new name: aString; table: aTable.
	^attribute
]

{ #category : #'as yet unclassified' }
MJSQLAttributes >> createRelationalElementWith: aTable [
	
	| att |
	
	att := MJFAMIXColumn new.
	att name: self name.
	att ownerTable: aTable.
	
	^att
	
]

{ #category : #'as yet unclassified' }
MJSQLAttributes >> table [
	^table
	
]

{ #category : #'as yet unclassified' }
MJSQLAttributes >> table: aTable [
	table := aTable.
	
]

{ #category : #'as yet unclassified' }
MJSQLAttributes >> type: aString [
	type := aString.
]
