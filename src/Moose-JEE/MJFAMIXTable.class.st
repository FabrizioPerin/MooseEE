Class {
	#name : #MJFAMIXTable,
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
MJFAMIXTable class >> annotation [
	<MSEClass: #Table super: #MJFAMIXRelationalEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
MJFAMIXTable >> addColumn: aFAMIXTablesColumn [

	self columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
MJFAMIXTable >> columns [
	^columns
]

{ #category : #accessing }
MJFAMIXTable >> columns: aOrderedCollection [

	columns := aOrderedCollection.
]

{ #category : #initialization }
MJFAMIXTable >> initialize [

	super initialize.
	columns := OrderedCollection new.
	ownerDataBase := nil.
	nameAsRegExIgCa := nil.
	nameAsRegEx := nil.
]

{ #category : #accessing }
MJFAMIXTable >> nameAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [('.*', self name, '.*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #accessing }
MJFAMIXTable >> nameAsRegexIgnoringCase [
	^nameAsRegExIgCa isNil 
		ifTrue: [('.*', self name, '.*') asRegexIgnoringCase]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
MJFAMIXTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
MJFAMIXTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]
