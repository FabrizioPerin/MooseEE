"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #MJFAMIXDBAccess,
	#superclass : #FAMIXAssociation,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
MJFAMIXDBAccess class >> annotation [
	<MSEClass: #DBAccess super: 'FAMIX.Association'>
	<package: #FAMIX>
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
