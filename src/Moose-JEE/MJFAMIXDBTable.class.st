Class {
	#name : #MJFAMIXDBTable,
	#superclass : #MJFAMIXRelationalEntity,
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
MJFAMIXDBTable class >> annotation [
	<MSEClass: #Table super: #MJFAMIXRelationalEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
MJFAMIXDBTable >> addColumn: aFAMIXTablesColumn [

	self columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
MJFAMIXDBTable >> columns [
	^columns
]

{ #category : #accessing }
MJFAMIXDBTable >> columns: aOrderedCollection [

	columns := aOrderedCollection.
]

{ #category : #initialization }
MJFAMIXDBTable >> initialize [

	super initialize.
	columns := OrderedCollection new.
	ownerDataBase := nil.
	nameAsRegExIgCa := nil.
	nameAsRegEx := nil.
]

{ #category : #accessing }
MJFAMIXDBTable >> nameAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [('.*', self name, '.*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #accessing }
MJFAMIXDBTable >> nameAsRegexIgnoringCase [
	^nameAsRegExIgCa isNil 
		ifTrue: [('.*', self name, '.*') asRegexIgnoringCase]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
MJFAMIXDBTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
MJFAMIXDBTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]
