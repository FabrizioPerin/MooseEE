Class {
	#name : #FAMIXDBTable,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'columns',
		'dataBase',
		'ownerDataBase',
		'nameAsRegExIgCa',
		'nameAsRegEx'
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
	nameAsRegExIgCa := nil.
	nameAsRegEx := nil.
]

{ #category : #accessing }
FAMIXDBTable >> nameAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [('.*', self name, '.*') asRegex]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
FAMIXDBTable >> nameAsRegexIgnoringCase [
	^nameAsRegExIgCa isNil 
		ifTrue: [('.*', self name, '.*') asRegexIgnoringCase]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
FAMIXDBTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
FAMIXDBTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]
