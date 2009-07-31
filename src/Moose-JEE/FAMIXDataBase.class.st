Class {
	#name : #FAMIXDataBase,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'tables'
	],
	#category : #'Moose-JEE'
}

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
