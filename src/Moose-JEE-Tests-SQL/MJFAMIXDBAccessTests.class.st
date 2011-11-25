Class {
	#name : #MJFAMIXDBAccessTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXDBAccessTests >> testAnnotation [
	self assert: FAMIXDBAccess annotation == FAMIXDBAccess.
]

{ #category : #testsOnJEEModel }
MJFAMIXDBAccessTests >> testMJFAMIXDBAccessCreateWithAccessorAndAccessed [
	
	| sourcedEntity table dbAccess |
	
	sourcedEntity := FAMIXSourcedEntity new.
	table := FAMIXTable new name: #Table1.
	
	dbAccess := FAMIXDBAccess new accessorEntity: sourcedEntity; accessedEntity: table.
	
	sourcedEntity addDBAccess: dbAccess.
	table addSourceAccessors: dbAccess.
	
	self assert: (dbAccess isMemberOf: FAMIXDBAccess).
	self assert: (dbAccess accessorEntity = sourcedEntity).
	self assert: (dbAccess accessedEntity = table).
	self assert: (dbAccess from = sourcedEntity).
	self assert: (dbAccess to = table).
	  
	
	
]

{ #category : #testsOnJEEModel }
MJFAMIXDBAccessTests >> testMJFAMIXDBAccessCreation [
	
	| mooseModel sourcedEntity table dbAccess |
		
	dbAccess := FAMIXDBAccess new.
	
	self assert: (dbAccess isMemberOf: FAMIXDBAccess).
	self assert: (dbAccess accessedEntity = nil).
	self assert: (dbAccess accessorEntity = nil).
]

{ #category : #testsOnJEEModel }
MJFAMIXDBAccessTests >> testPrintOn [ 
	
	| sourcedEntity table dbAccess stream |
	
	sourcedEntity := FAMIXSourcedEntity new.
	table := FAMIXTable new name: #Table1.
	
	dbAccess := FAMIXDBAccess new accessorEntity: sourcedEntity; accessedEntity: table.
	
	sourcedEntity addDBAccess: dbAccess.
	table addSourceAccessors: dbAccess.
	
	self assert: (dbAccess isMemberOf: FAMIXDBAccess).
	self assert: (dbAccess accessorEntity = sourcedEntity).
	self assert: (dbAccess accessedEntity = table).
	self assert: (dbAccess from = sourcedEntity).
	self assert: (dbAccess to = table).
	 
	stream := ReadWriteStream on: ''.
	dbAccess printOn: stream.
	
	self assert: (stream contents = (dbAccess accessorEntity name asString , ' -> ' , dbAccess accessedEntity name asString , ' (DBAccess)')).
	
	
]
