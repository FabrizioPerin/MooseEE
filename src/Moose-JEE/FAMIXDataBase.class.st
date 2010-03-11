Class {
	#name : #FAMIXDataBase,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'tables'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXDataBase class >> annotation [
	<MSEClass: #DataBase super: #FAMIXRelationalEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
FAMIXDataBase >> addTable: aFAMIXDBTable [
	tables add: aFAMIXDBTable.
]

{ #category : #initialization }
FAMIXDataBase >> initialize [
	super initialize.
	tables := OrderedCollection new.
]

{ #category : #accessing }
FAMIXDataBase >> tables [
	^tables
]

{ #category : #accessing }
FAMIXDataBase >> tables: aOrderedCollection [

	tables := aOrderedCollection.
]
