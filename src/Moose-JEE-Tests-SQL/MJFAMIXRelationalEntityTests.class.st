Class {
	#name : #MJFAMIXRelationalEntityTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testAnnotation [
	self assert: MJFAMIXRelationalEntity annotation == MJFAMIXRelationalEntity.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testBelongsTo [
	self assert: MJFAMIXRelationalEntity new belongsTo = ''.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testMappedNamedEntities [
	| table class mapping mm |
	
	mm := MooseModel new.
	table := MJFAMIXTable new.
	class := FAMIXClass new.
	
	mapping := MJFAMIXMapping new
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
	
	table := MJFAMIXTable new name: #Table1.
	
	dbAccess := MJFAMIXDBAccess new accessedEntity: table.
	
	table addSourceAccessors: dbAccess.
	
	self assert: (table isMemberOf: MJFAMIXTable).

	self assert: (table sourceAccessors isMemberOf: FMMultivalueLink).
	self assert: (table sourceAccessors first = dbAccess).
	self assert: (table sourceAccessors first to = table).
]
