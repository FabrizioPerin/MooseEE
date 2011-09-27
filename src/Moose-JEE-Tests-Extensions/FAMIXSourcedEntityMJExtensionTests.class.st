Class {
	#name : #FAMIXSourcedEntityMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #tests }
FAMIXSourcedEntityMJExtensionTests >> testAccessedRelationalEntities [
	
	| sourcedEntity dbAccess table mm |
	
	sourcedEntity := FAMIXSourcedEntity new.
	table := MJFAMIXTable new name: #table1.
	
	dbAccess := MJFAMIXDBAccess new accessorEntity: sourcedEntity; accessedEntity: table.

	sourcedEntity addDBAccess: dbAccess.
	table addSourceAccessors: dbAccess.
	
	mm := MooseModel new name: #test.
	   
	mm add: dbAccess.
	mm add: table.
	mm add: sourcedEntity.
	
	self assert: (sourcedEntity accessedRelationalEntities size = 1).
	self assert: (sourcedEntity accessedRelationalEntities first = table).

]

{ #category : #tests }
FAMIXSourcedEntityMJExtensionTests >> testAccessorRelationalEntities [
	| sourcedEntity dbAccess table mm |
	
	sourcedEntity := FAMIXSourcedEntity new.
	table := MJFAMIXTable new name: #table1.
	
	dbAccess := MJFAMIXDBAccess new accessorEntity: sourcedEntity; accessedEntity: table.

	sourcedEntity addDBAccess: dbAccess.
	table addSourceAccessors: dbAccess.
	
	mm := MooseModel new name: #test.
	   
	mm add: dbAccess.
	mm add: table.
	mm add: sourcedEntity.
	
	self assert: (table accessorSourceEntities size = 1).
	self assert: (table accessorSourceEntities first = sourcedEntity).

]

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
