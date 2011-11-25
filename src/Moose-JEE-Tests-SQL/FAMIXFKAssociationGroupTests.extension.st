Extension { #name : #FAMIXFKAssociationGroupTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXFKAssociationGroupTests >> testExportListOfFKsAsCSVFile [
	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

	logicLayer := mooseModel allFKAssociations.

	self deny: (FileDirectory default fileNames includes: 'listOfFkAssoc').

	logicLayer exportListOfFKsAsCSVFileNamed: 'listOfFkAssoc'.
	
	self assert: (FileDirectory default fileNames includes: 'listOfFkAssoc.csv').
	
	FileDirectory default deleteFileNamed: 'listOfFkAssoc.csv'.
	self deny: (FileDirectory default fileNames includes: 'listOfFkAssoc.csv').
]
