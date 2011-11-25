Extension { #name : #FAMIXColumnTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXColumnTests >> testIsUniqueFromAModel [
	| jEETestModel mooseModel table1 |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).

	self assert: ((table1 columns select: [:each | each name = #Column4 ]) first isUnique).
	self deny: ((table1 columns select: [:each | each name = #Column6 ]) first isUnique).
]
