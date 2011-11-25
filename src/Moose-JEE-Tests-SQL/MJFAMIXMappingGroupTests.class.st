Class {
	#name : #MJFAMIXMappingGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXMappingGroupTests >> testAnnotation [
	self assert: FAMIXMappingGroup annotation == FAMIXMappingGroup.
]

{ #category : #tests }
MJFAMIXMappingGroupTests >> testSaveListOfMapsOnFileNamed [
	| mooseModel class table mapping mapGroup |
	
	mooseModel := JEETestModels new sampleMooseModelWithDB.
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	mapping := FAMIXMapping new mapTarget: table; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel add: mapping.
	
	mapGroup := mooseModel allMaps.

	self deny: (FileDirectory default fileNames includes: 'listOfMaps.out').

	mapGroup saveListOfMapsOnFileNamed: 'listOfMaps.out'.
	
	self assert: (FileDirectory default fileNames includes: 'listOfMaps.out').
	
	FileDirectory default deleteFileNamed: 'listOfMaps.out'.
	self deny: (FileDirectory default fileNames includes: 'listOfMaps.out').
]
