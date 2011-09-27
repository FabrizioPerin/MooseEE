Class {
	#name : #MJFAMIXDataBase,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'tables'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXDataBase class >> annotation [
	<MSEClass: #DataBase super: #MJFAMIXRelationalEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #accessing }
MJFAMIXDataBase >> addTable: aFAMIXDBTable [
	tables add: aFAMIXDBTable.
]

{ #category : #initialization }
MJFAMIXDataBase >> initialize [
	super initialize.
	tables := OrderedCollection new.
]

{ #category : #accessing }
MJFAMIXDataBase >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Database)'
]

{ #category : #accessing }
MJFAMIXDataBase >> tables [
	^tables
]

{ #category : #accessing }
MJFAMIXDataBase >> tables: aOrderedCollection [

	tables := aOrderedCollection.
]
