Class {
	#name : #MJFAMIXFKAssociation,
	#superclass : #MJAssociation,
	#instVars : [
		'sourceTable',
		'targetTable'
	],
	#category : #'Moose-JEE-SQL-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation class >> annotation [
	<MSEClass: #MJFAMIXFKAssociation super: #MJAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> from [

	^ self sourceColumn
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> initialize [
	super initialize.
	
	sourceTable := nil.
	targetTable := nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (FK association)'
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> sourceColumn [

	<MSEProperty: #sourceColumn type: #MJFAMIXRelationalEntity opposite: #references>
	<MSEComment: 'Relational element references another relational element.'>
	
	^sourceTable 
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> sourceColumn: aRelationalEntity [
	
	sourceTable := FMMultivalueLink 
								on: self
								update: #references
								from: self sourceColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #MJFAMIXRelationalEntity opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	
	^targetTable
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> targetColumn: aRelationalEntity [

	targetTable := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> to [

	^ self targetColumn
]
