Class {
	#name : #FAMIXDBTable,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'columns',
		'dataBase',
		'ownerDataBase'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXDBTable class >> annotation [
	<MSEClass: 'Table' super: #FAMIXNamedEntity>
	<package: 'FAMIX'>
	<abstract>
]

{ #category : #accessing }
FAMIXDBTable >> addColumn: aFAMIXTablesColumn [

	self columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
FAMIXDBTable >> columns [
	^columns
]

{ #category : #accessing }
FAMIXDBTable >> columns: aOrderedCollection [

	columns := aOrderedCollection.
]

{ #category : #initialization }
FAMIXDBTable >> initialize [

	super initialize.
	columns := OrderedCollection new.
	ownerDataBase := nil.
]

{ #category : #accessing }
FAMIXDBTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
FAMIXDBTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]
