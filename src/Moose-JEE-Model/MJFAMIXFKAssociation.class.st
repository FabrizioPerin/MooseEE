Class {
	#name : #MJFAMIXFKAssociation,
	#superclass : #MJAssociation,
	#instVars : [
		'sourceTable',
		'targetTable'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation class >> annotation [
	<MSEClass: #MJFAMIXFKAssociation super: #MJAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> from [

	^ self sourceTable
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> initialize [
	super initialize.
	
	sourceTable := nil.
	targetTable := nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> sourceTable [

	<MSEProperty: #sourceTable type: #MJFAMIXRelationalEntity opposite: #references>
	<MSEComment: 'Relational element references another relational element.'>
	
	^sourceTable 
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> sourceTable: aRelationalEntity [
	
	sourceTable := FMMultivalueLink 
								on: self
								update: #references
								from: self sourceTable
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> targetTable [
	<MSEProperty: #targetTable type: #MJFAMIXRelationalEntity opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	
	^targetTable
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> targetTable: aRelationalEntity [

	targetTable := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetTable
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociation >> to [

	^ self targetTable
]
