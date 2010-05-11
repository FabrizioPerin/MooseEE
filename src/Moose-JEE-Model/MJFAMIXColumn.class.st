Class {
	#name : #MJFAMIXColumn,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'isPK',
		'isFK',
		'ownerTable',
		'columnReference',
		'type'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXColumn class >> annotation [
	<MSEClass: #TableColumn super: #MJFAMIXRelationalEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
MJFAMIXColumn >> columnReference [

	^columnReference
]

{ #category : #accessing }
MJFAMIXColumn >> columnReference: aTablesColumnOrNil [

	columnReference := aTablesColumnOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> initialize [
	super initialize.
	
	isPK := nil.
	isFK := nil.
	columnReference := nil.
	ownerTable := nil.
	type := nil.
]

{ #category : #accessing }
MJFAMIXColumn >> isFK [
	^isFK
]

{ #category : #accessing }
MJFAMIXColumn >> isFK: aBooleanOrNil [

	isFK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> isPK [

	^isPK
]

{ #category : #accessing }
MJFAMIXColumn >> isPK: aBooleanOrNil [

	isPK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> ownerTable [

	^ownerTable
]

{ #category : #accessing }
MJFAMIXColumn >> ownerTable: anObjectOrNil [

	ownerTable := anObjectOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> type [
	^type
]

{ #category : #accessing }
MJFAMIXColumn >> type: aString [
	type := aString
]
