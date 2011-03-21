Class {
	#name : #FAMIXSourcedEntityMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
FAMIXSourcedEntityMJExtensionTests >> testDBAccesses [
	
	| sourcedEntity dbAccess |
	
	sourcedEntity := FAMIXSourcedEntity new.
	
	dbAccess := MJFAMIXDBAccess new accessorEntity: sourcedEntity.

	sourcedEntity addDBAccess: dbAccess.
	
	self assert: (sourcedEntity isMemberOf: FAMIXSourcedEntity).

	self assert: (sourcedEntity dbAccesses isMemberOf: FMMultivalueLink).
	self assert: (sourcedEntity dbAccesses size = 1).
	self assert: (sourcedEntity dbAccesses first = dbAccess).
	self assert: (sourcedEntity dbAccesses first from = sourcedEntity).

]
