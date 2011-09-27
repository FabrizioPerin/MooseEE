Class {
	#name : #MJFAMIXColumn,
	#superclass : #MJFAMIXRelationalEntity,
	#instVars : [
		'isPK',
		'isFK',
		'ownerTable',
		'type',
		'used',
		'isUnique',
		'canBeNull',
		'defaultValue'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXColumn class >> annotation [
	<MSEClass: #MJFAMIXColumn super: #MJFAMIXRelationalEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #accessing }
MJFAMIXColumn >> canBeNull [
	<property: #canBeNull longName: 'Can Be Null' description:
			'This column can be null'>
	^ canBeNull
]

{ #category : #accessing }
MJFAMIXColumn >> canBeNull: anObject [
	canBeNull := anObject
]

{ #category : #accessing }
MJFAMIXColumn >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
MJFAMIXColumn >> defaultValue: wathever [ 
	defaultValue := wathever.
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
	isUnique := nil.
	canBeNull := nil.
]

{ #category : #accessing }
MJFAMIXColumn >> isFK [
	<property: #isFK longName: 'is Foreign Key' description:
			'This column is foreign key from another table'>
	^isFK
]

{ #category : #accessing }
MJFAMIXColumn >> isFK: aBooleanOrNil [

	isFK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> isPK [
	<property: #isPK longName: 'is Primary Key' description:
			'This column is a primary key'>
	^isPK
]

{ #category : #accessing }
MJFAMIXColumn >> isPK: aBooleanOrNil [

	isPK := aBooleanOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> isUnique [
	<property: #isUnique longName: 'is Unique' description:
			'The content of this column must be unique'>
	^ isUnique
]

{ #category : #accessing }
MJFAMIXColumn >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
MJFAMIXColumn >> ownerTable [
	<navigation: #ownerTable>
	"ownerTable isNil ifTrue: [
		ownerTable := self mooseModel allTables 
			detect: [:table | table columns anySatisfy: [:column | column = self]]
			ifNone: [nil]]."
	
	^ownerTable
]

{ #category : #accessing }
MJFAMIXColumn >> ownerTable: anObjectOrNil [

	ownerTable := anObjectOrNil.
]

{ #category : #accessing }
MJFAMIXColumn >> printOn: aStream [
	| table |
	
	table := self ownerTable.
	table ifNotNil: [
		table mooseNameOn: aStream.
		aStream nextPutAll: '>>>'].
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Column)'.
]

{ #category : #accessing }
MJFAMIXColumn >> type [
	<property: #type longName: 'type' description:
			'Type of this column'>
	^type
]

{ #category : #accessing }
MJFAMIXColumn >> type: aString [
	type := aString
]
