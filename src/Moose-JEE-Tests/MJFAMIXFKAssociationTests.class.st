Class {
	#name : #MJFAMIXFKAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKAssociationCreation [
	
	| jEETestModel mooseModel table1 table2 fkAssoc map class table |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := mooseModel entityNamed: #Table1.
	table2 := mooseModel entityNamed: #Table2.
	
	fkAssoc := MJFAMIXFKAssociation new targetColumn: table1; sourceColumn: table2.
	
	table1 addReferencedBy: fkAssoc.
	table2 addReferences: fkAssoc.
	
	mooseModel add: fkAssoc.
	
	self assert: ((mooseModel allWithType: MJFAMIXFKAssociation) size = 1).
	
	map := ((mooseModel allWithType: MJFAMIXFKAssociation) select: [:each | each from = table2 and: [each to = table1]]).
	self assert: map size = 1.

]
