Class {
	#name : #MJFAMIXMappingGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXMappingGroupTests >> testAnnotation [
	self assert: MJFAMIXMappingGroup annotation == MJFAMIXMappingGroup.
]

{ #category : #tests }
MJFAMIXMappingGroupTests >> testSaveListOfMapsOnFileNamed [
	| mooseModel class table mapping mapGroup |
	
	mooseModel := JEETestModels new sampleMooseModelWithDB.
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
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
