Class {
	#name : #MJFAMIXFKAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXFKAssociationTests >> testAnnotation [
	self assert: MJFAMIXFKAssociation annotation == MJFAMIXFKAssociation.
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKAssociationCreation [

	| fkAssoc mooseModel |
	
	fkAssoc := MJFAMIXFKAssociation new.
	
	self assert: (fkAssoc isMemberOf:  MJFAMIXFKAssociation).
	
	mooseModel := MooseModel new.
	mooseModel add: fkAssoc.
	
	self assert: ((mooseModel allWithType: MJFAMIXFKAssociation) size = 1).

]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKFrom [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := MJFAMIXFKAssociation new sourceColumn: table1.
	
	self assert: (fkAssoc from = table1).
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKFromAndTo [
	
	| jEETestModel mooseModel table1 table2 fkAssoc map class table |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := mooseModel entityNamed: #Table1.
	table2 := mooseModel entityNamed: #Table2.
	
	fkAssoc := MJFAMIXFKAssociation new targetColumn: table1; sourceColumn: table2.
	
	self assert: (fkAssoc targetColumn = fkAssoc to).  
	self assert: (fkAssoc to = table1).
	  
	self assert: (fkAssoc sourceColumn = fkAssoc from).  
	self assert: (fkAssoc from = table2).
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKSourceColumn [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := MJFAMIXFKAssociation new sourceColumn: table1.
	
	self assert: (fkAssoc sourceColumn = table1).
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKTargetColumn [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := MJFAMIXFKAssociation new targetColumn: table1.
	
	self assert: (fkAssoc targetColumn = table1).
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testMJFAMIXFKTo [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := MJFAMIXFKAssociation new targetColumn: table1.
	
	self assert: (fkAssoc to = table1).
]

{ #category : #testsOnJEEModel }
MJFAMIXFKAssociationTests >> testPrintOn [
	| jEETestModel mooseModel table1 table2 fkAssoc stream |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := mooseModel entityNamed: #Table1.
	table2 := mooseModel entityNamed: #Table2.
	
	fkAssoc := MJFAMIXFKAssociation new targetColumn: table1; sourceColumn: table2.
	
	self assert: (fkAssoc targetColumn = fkAssoc to).  
	self assert: (fkAssoc to = table1).
	  
	self assert: (fkAssoc sourceColumn = fkAssoc from).  
	self assert: (fkAssoc from = table2).
	
	stream := ReadWriteStream on: ''.
	fkAssoc printOn: stream.
	
	self assert: (stream contents = (fkAssoc sourceColumn name asString , ' -> ' , fkAssoc targetColumn name asString , ' (FK association)')).
]
