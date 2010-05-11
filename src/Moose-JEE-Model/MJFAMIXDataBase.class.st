Class {
	#name : #MJFAMIXDataBase,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'tables'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXDataBase class >> annotation [
	<MSEClass: #DataBase super: #MJFAMIXRelationalEntity>
	<package: #FAMIX>
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
MJFAMIXDataBase >> tables [
	^tables
]

{ #category : #accessing }
MJFAMIXDataBase >> tables: aOrderedCollection [

	tables := aOrderedCollection.
]
