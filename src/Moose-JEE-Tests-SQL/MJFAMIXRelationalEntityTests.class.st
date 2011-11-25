Class {
	#name : #MJFAMIXRelationalEntityTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testAnnotation [
	self assert: FAMIXRelationalEntity annotation == FAMIXRelationalEntity.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testBelongsTo [
	self assert: FAMIXRelationalEntity new belongsTo = ''.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testMappedNamedEntities [
	| table class mapping mm |
	
	mm := MooseModel new.
	table := FAMIXTable new.
	class := FAMIXClass new.
	
	mapping := FAMIXMapping new
		mapTarget: table;
		mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mm add: class.
	mm add: table.
	mm add: mapping.
	
	self assert: table mappedNamedEntities size = 1.
	self assert: table mappedNamedEntities first = class
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testSourceAccessors [
	
	| table dbAccess |
	
	table := FAMIXTable new name: #Table1.
	
	dbAccess := FAMIXDBAccess new accessedEntity: table.
	
	table addSourceAccessors: dbAccess.
	
	self assert: (table isMemberOf: FAMIXTable).

	self assert: (table sourceAccessors isMemberOf: FMMultivalueLink).
	self assert: (table sourceAccessors first = dbAccess).
	self assert: (table sourceAccessors first to = table).
]
