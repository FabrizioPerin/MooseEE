"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #MJFAMIXDBAccess,
	#superclass : #MJAssociation,
	#instVars : [
		'accessorEntity',
		'accessedEntity'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'fame annotation' }
MJFAMIXDBAccess class >> annotation [
	<MSEClass: #DBAccess super: #FAMIXAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> accessedEntity [
	
	<MSEProperty: #accessedEntity type: #MJFAMIXRelationalEntity opposite: #sourceAccessors>
	<MSEComment: 'Relational entity accessed by a sourced entity.'>
	
	^accessedEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> accessedEntity: aRelationalEntity [
	

	accessedEntity := FMMultivalueLink 
								on: self
								update: #sourceAccessors
								from: self accessedEntity  
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> accessorEntity [

	<MSEProperty: #accessorEntity type: #FAMIXSourcedEntity opposite: #dbAccesses>
	<MSEComment: 'Source entity that access a Relational entity.'>
	
	^accessorEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> accessorEntity: aSourcedEntity [

	accessorEntity := FMMultivalueLink 
								on: self
								update: #dbAccesses
								from: self accessorEntity  
								to: aSourcedEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> from [
	^ self accessorEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> initialize [
	super initialize.
	
	accessorEntity := nil.
	accessedEntity := nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (DBAccess)'
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> to [
	^ self accessedEntity
]
