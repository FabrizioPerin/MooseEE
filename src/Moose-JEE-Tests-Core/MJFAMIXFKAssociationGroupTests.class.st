Class {
	#name : #MJFAMIXFKAssociationGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXFKAssociationGroupTests >> testAnnotation [
	self assert: MJFAMIXFKAssociationGroup annotation == MJFAMIXFKAssociationGroup.
]

{ #category : #tests }
MJFAMIXFKAssociationGroupTests >> testExportListOfFKsAsCSVFile [
	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.

	logicLayer := mooseModel allFKAssociations.

	self deny: (FileDirectory default fileNames includes: 'listOfFkAssoc').

	logicLayer exportListOfFKsAsCSVFileNamed: 'listOfFkAssoc'.
	
	self assert: (FileDirectory default fileNames includes: 'listOfFkAssoc.csv').
	
	FileDirectory default deleteFileNamed: 'listOfFkAssoc.csv'.
	self deny: (FileDirectory default fileNames includes: 'listOfFkAssoc.csv').
]
