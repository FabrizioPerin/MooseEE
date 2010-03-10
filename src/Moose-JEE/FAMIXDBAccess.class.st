"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #FAMIXDBAccess,
	#superclass : #FAMIXAssociation,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXDBAccess class >> annotation [
	<MSEClass: #DBAccess super: 'FAMIX.Association'>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> from [

	^ self accessorEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> to [

	^ self 
]
