"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #MJFAMIXDBAccess,
	#superclass : #MJAssociation,
	#category : #'Moose-JEE-Model'
}

{ #category : #'fame annotation' }
MJFAMIXDBAccess class >> annotation [
	<MSEClass: #DBAccess super: #FAMIXAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> from [
	^ self accessorEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess >> to [
	^ self
]
