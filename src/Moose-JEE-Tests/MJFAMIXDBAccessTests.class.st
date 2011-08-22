Class {
	#name : #MJFAMIXDBAccessTests,
	#superclass : #MJAssociationTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXDBAccessTests >> testAnnotation [
	self assert: MJFAMIXDBAccess annotation == MJFAMIXDBAccess.
]

{ #category : #testsOnJEEModel }
MJFAMIXDBAccessTests >> testMJFAMIXDBAccessCreateWithAccessorAndAccessed [
	
	| sourcedEntity table dbAccess |
	
	sourcedEntity := FAMIXSourcedEntity new.
	table := MJFAMIXTable new name: #Table1.
	
	dbAccess := MJFAMIXDBAccess new accessorEntity: sourcedEntity; accessedEntity: table.
	
	sourcedEntity addDBAccess: dbAccess.
	table addSourceAccessors: dbAccess.
	
	self assert: (dbAccess isMemberOf: MJFAMIXDBAccess).
	self assert: (dbAccess accessorEntity = sourcedEntity).
	self assert: (dbAccess accessedEntity = table).
	 self assert: (dbAccess from = sourcedEntity).
	self assert: (dbAccess to = table).
	  
	
	
]

{ #category : #testsOnJEEModel }
MJFAMIXDBAccessTests >> testMJFAMIXDBAccessCreation [
	
	| mooseModel sourcedEntity table dbAccess |
		
	dbAccess := MJFAMIXDBAccess new.
	
	self assert: (dbAccess isMemberOf: MJFAMIXDBAccess).
	self assert: (dbAccess accessedEntity = nil).
	self assert: (dbAccess accessorEntity = nil).
]
