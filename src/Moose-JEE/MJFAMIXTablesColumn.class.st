Class {
	#name : #MJFAMIXTablesColumn,
	#superclass : #MJFAMIXRelationalEntity,
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
MJFAMIXTablesColumn class >> annotation [
	<MSEClass: #TableColumn super: #MJFAMIXRelationalEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
MJFAMIXTablesColumn >> columnReference [

	^columnReference
]

{ #category : #accessing }
MJFAMIXTablesColumn >> columnReference: aTablesColumnOrNil [

	columnReference := aTablesColumnOrNil.
]

{ #category : #accessing }
MJFAMIXTablesColumn >> initialize [
	super initialize.
	
	isPK := nil.
	isFK := nil.
	columnReference := nil.
	ownerTable := nil.
	type := nil.
]

{ #category : #accessing }
MJFAMIXTablesColumn >> isFK [
	^isFK
]

{ #category : #accessing }
MJFAMIXTablesColumn >> isFK: aBooleanOrNil [

	isFK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXTablesColumn >> isPK [

	^isPK
]

{ #category : #accessing }
MJFAMIXTablesColumn >> isPK: aBooleanOrNil [

	isPK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXTablesColumn >> ownerTable [

	^ownerTable
]

{ #category : #accessing }
MJFAMIXTablesColumn >> ownerTable: anObjectOrNil [

	ownerTable := anObjectOrNil.
]

{ #category : #accessing }
MJFAMIXTablesColumn >> type [
	^type
]

{ #category : #accessing }
MJFAMIXTablesColumn >> type: aString [
	type := aString
]
