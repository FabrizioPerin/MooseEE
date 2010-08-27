Class {
	#name : #MJSQLAttributes,
	#superclass : #MJSQLRelationalElements,
	#instVars : [
		'table',
		'type',
		'isPK',
		'unique',
		'isFK',
		'defaultValue',
		'canBeNull'
	],
	#category : #'Moose-JEE-SQL'
}

{ #category : #'initialize-release' }
MJSQLAttributes class >> name: aString ownedBy: aTable [

	| attribute |
	
	attribute := self new name: aString; table: aTable.
	^attribute
]

{ #category : #accessing }
MJSQLAttributes >> canBeNull [
	^ canBeNull
]

{ #category : #initialization }
MJSQLAttributes >> canBeNull: aBoolean [
	canBeNull := aBoolean
]

{ #category : #initialization }
MJSQLAttributes >> createRelationalElementWith: aTable [
	
	| att |
	
	att := MJFAMIXColumn new.
	att name: self name.
	att ownerTable: aTable.
	
	^att
	
]

{ #category : #accessing }
MJSQLAttributes >> defaultValue [
	^ defaultValue
]

{ #category : #initialization }
MJSQLAttributes >> defaultValue: anObject [
	defaultValue := anObject
]

{ #category : #initialization }
MJSQLAttributes >> initialize [

	super initialize.
	table := nil.
	type := nil.
	isPK := nil. 
	canBeNull := true. 
	unique := nil. 
	isFK := nil. 
	defaultValue:= nil.
	
]

{ #category : #accessing }
MJSQLAttributes >> isFK [
	^ isFK
]

{ #category : #initialization }
MJSQLAttributes >> isFK: aBoolean [
	isFK := aBoolean
]

{ #category : #accessing }
MJSQLAttributes >> isPK [
	^ isPK
]

{ #category : #initialization }
MJSQLAttributes >> isPK: aBoolean [
	isPK := aBoolean
]

{ #category : #accessing }
MJSQLAttributes >> isUnique [
	^ unique
]

{ #category : #initialization }
MJSQLAttributes >> isUnique: aBoolean [
	unique := aBoolean
]

{ #category : #accessing }
MJSQLAttributes >> table [
	^table
	
]

{ #category : #initialization }
MJSQLAttributes >> table: aTable [
	table := aTable.
	
]

{ #category : #accessing }
MJSQLAttributes >> type [
	^ type
]

{ #category : #initialization }
MJSQLAttributes >> type: aString [
	type := aString.
]
