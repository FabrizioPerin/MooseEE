Class {
	#name : #MJFAMIXColumn,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'isPK',
		'isFK',
		'ownerTable',
		'type',
		'used'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXColumn class >> annotation [
	<MSEClass: #MJFAMIXColumn super: #MJFAMIXRelationalEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #accessing }
MJFAMIXColumn >> inUse [
	used isNil 
		ifTrue: [self inUse: self mappedNamedEntities isEmpty not].
	^used
]

{ #category : #accessing }
MJFAMIXColumn >> inUse: aBooleanOrNil [
	used := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> initialize [
	super initialize.
	
	isPK := nil.
	isFK := nil.
	ownerTable := nil.
	type := nil.
	used := nil.
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

	ownerTable isNil ifTrue: [
		ownerTable := self mooseModel allTables detect: [:table | 
			(table columns select: [:column | column = self]) isEmpty 
				ifTrue: [false]
				ifFalse: [true]]].

	^ownerTable
]

{ #category : #accessing }
MJFAMIXColumn >> ownerTable: anObjectOrNil [

	ownerTable := anObjectOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> printOn: aStream [

	self ownerTable isNil ifFalse: [aStream nextPutAll: self ownerTable name].
	aStream nextPutAll: '>>'.
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Column)'.
]

{ #category : #accessing }
MJFAMIXColumn >> type [
	^type
]

{ #category : #accessing }
MJFAMIXColumn >> type: aString [
	type := aString
]
