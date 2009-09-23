Class {
	#name : #FAMIXTablesColumn,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'isPK',
		'isFK',
		'ownerTable',
		'columnReference',
		'type'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXTablesColumn class >> annotation [
	<MSEClass: 'TableColumn' super: #FAMIXNamedEntity>
	<package: 'FAMIX'>
	<abstract>
]

{ #category : #accessing }
FAMIXTablesColumn >> columnReference [

	^columnReference
]

{ #category : #accessing }
FAMIXTablesColumn >> columnReference: aTablesColumnOrNil [

	columnReference := aTablesColumnOrNil.
]

{ #category : #accessing }
FAMIXTablesColumn >> isFK [
	^isFK
]

{ #category : #accessing }
FAMIXTablesColumn >> isFK: aBooleanOrNil [

	isFK := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXTablesColumn >> isPK [

	^isPK
]

{ #category : #accessing }
FAMIXTablesColumn >> isPK: aBooleanOrNil [

	isPK := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXTablesColumn >> ownerTable [

	^ownerTable
]

{ #category : #accessing }
FAMIXTablesColumn >> ownerTable: anObjectOrNil [

	ownerTable := anObjectOrNil.
]

{ #category : #accessing }
FAMIXTablesColumn >> type [
	^type
]

{ #category : #accessing }
FAMIXTablesColumn >> type: aString [
	type := aString
]
