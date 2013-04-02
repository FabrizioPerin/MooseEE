Extension { #name : #FAMIXFKAssociationGroupTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXFKAssociationGroupTests >> testExportListOfFKsAsCSVFile [
	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

	logicLayer := mooseModel allFKAssociations.

	self deny: (FileSystem workingDirectory fileNames includes: 'listOfFkAssoc').

	logicLayer exportListOfFKsAsCSVFileNamed: 'listOfFkAssoc'.
	
	self assert: (FileSystem workingDirectory fileNames includes: 'listOfFkAssoc.csv').

	(FileSystem workingDirectory / 'listOfFkAssoc.csv') asFileReference delete. 
	
	self deny: (FileSystem workingDirectory fileNames includes: 'listOfFkAssoc.csv').
]
