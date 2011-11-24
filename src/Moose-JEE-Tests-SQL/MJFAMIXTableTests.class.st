Class {
	#name : #MJFAMIXTableTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testAddColumn [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	
	table3 addColumn: (MJFAMIXColumn new name: #Column2).
					
	self assert: (table3 columns size = 9).
]

{ #category : #tests }
MJFAMIXTableTests >> testAnnotation [
	self assert: MJFAMIXTable annotation == MJFAMIXTable.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	

]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testConstraints [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 constraints size = 2).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testCreation [
	| tab |

	tab := MJFAMIXTable new name: 'Table1'.
	
	self assert: (tab isMemberOf: MJFAMIXTable).     
	self assert: (tab name = 'Table1').  
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testFKColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self assert: (assetGroup fkColumns size = 0).
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: (asset fkColumns size = 2).
	self assert: (asset fkColumns allSatisfy: [:col | col name = 'A_Asset_Group_ID' or: [col name = 'AD_User_ID']]).
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: (user fkColumns size = 0).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testHasComposePK [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables select: #hasComposePK) size = 2.
	
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: asset hasComposePK.
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: user hasComposePK.
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self deny: assetGroup hasComposePK.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testInUse [
	| mm table mapping maps class att1 att2 col1 col2 mapatt1 mapatt2 |
	
	mm := MooseModel new.
	table := MJFAMIXTable new name: #Table1.
	class := FAMIXClass new.
	att1 := FAMIXAttribute new.
	att2 := FAMIXAttribute new.
	col1 := MJFAMIXColumn new name: #col1.
	col2 := MJFAMIXColumn new name: #col2.
	
	mapping := MJFAMIXMapping new
		mapTarget: table;
		mapSource: class.
	
	mapatt1 := MJFAMIXMapping new
		mapTarget: col1;
		mapSource: att1.
		
	mapatt2 := MJFAMIXMapping new
		mapTarget: col2;
		mapSource: att2.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mm add: class.
	mm add: table.
	mm add: att1.
	mm add: att2.
	mm add: col1.
	mm add: col2.
	mm add: mapping.
	mm add: mapatt1.
	mm add: mapatt2.

	self assert: (mm allColumns size = 2).
	
	maps := (mm allMaps select: [:each | each mapTarget isKindOf: MJFAMIXTable]).

	self assert: (maps size = 1).

	self assert: (maps anySatisfy: [:map | map mapTarget name = #Table1 and: [map mapTarget inUse]]).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameAsRegex [
	| table |

	table := MJFAMIXTable new name: #col1.
	
	self assert: (table nameAsRegex isMemberOf: RxMatcher).
	self assert: (table nameAsRegex matches: #col1).
	self assert: (table nameAsRegex matches: 'asfdcol1asdf').
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameAsRegexIgnoringCase [
	| col |
	
	col := MJFAMIXTable new name: #col1.
	
	self assert: (col nameAsRegexIgnoringCase isMemberOf: RxMatcher).
	self assert: (col nameAsRegexIgnoringCase matches: #col1).
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdcol1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdCOL1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: #COL1).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameWithAnnotationAsRegex [
	| jEETestModel mooseModel table1 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.

	self assert: (mooseModel allTables size = 3).
	self assert: (table1 nameWithAnnotationAsRegex matches: jEETestModel fakeSourceText).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNumberOfColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: asset numberOfColumns = 35.
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: user numberOfColumns = 30.
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self assert: assetGroup numberOfColumns = 10.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNumberOfForeignKeys [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: asset numberOfForeignKeys = 2.
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: user numberOfForeignKeys = 0.
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self assert: assetGroup numberOfForeignKeys = 0.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNumberOfPrimaryKeys [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: asset numberOfPrimaryKeys = 3.
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: user numberOfPrimaryKeys = 3.
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self assert: assetGroup numberOfPrimaryKeys = 1.
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testOwnerDataBase [
	| database dbTable1 |

	dbTable1 := MJFAMIXTable new
			name: 'Table1'.
			
	self assert: (dbTable1 ownerDataBase = nil).
	
	database := (MJFAMIXDataBase new name: #database1).
	dbTable1 ownerDataBase: database.

	self assert: (dbTable1 ownerDataBase = database)
	

]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testPKColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
	mooseModel ejbVersion: #EJB30.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	
	self assert: (assetGroup isMemberOf: MJFAMIXTable).
	self assert: (assetGroup pkColumns size = 1).
	
	self assert: (asset isMemberOf: MJFAMIXTable).
	self assert: (asset pkColumns size = 3).
	
	self assert: (user isMemberOf: MJFAMIXTable).
	self assert: (user pkColumns size = 3).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testPrintOn [
	| tab stream |

	tab := MJFAMIXTable new name: 'Table1'.
	
	stream := ReadWriteStream on: ''.
	tab printOn: stream.
	
	self assert: (stream contents = (tab name asString , ' (Table)')).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testSetColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	
	table3 columns: (Array with: (MJFAMIXColumn new name: #Column2) with: (MJFAMIXColumn new name: #Column1)) .
					
	self assert: (table3 columns size = 2).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencedByTables [	
	| jEETestModel mooseModel table3 tablesReferenceingTable3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	
	tablesReferenceingTable3 := table3 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 3).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencedByTablesOnTwoLevels [	
	| jEETestModel mooseModel table1 tablesReferenceingTable3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: MJFAMIXTable).
	
	tablesReferenceingTable3 := table1 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 4).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTables [	
	| jEETestModel mooseModel table3 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	
	referencedTables := table3 withDeepReferencesTables.
	
	self assert: (referencedTables size = 3).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferencedTables [
	| jEETestModel mooseModel table1 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: MJFAMIXTable).
	
	referencedTables := table1 withDeepReferencesTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table1).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferenceingTables [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: MJFAMIXTable).
	
	referencedTables := table5 withDeepReferencedByTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table5).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesOnTwoLevels [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: MJFAMIXTable).
	
	referencedTables := table5 withDeepReferencesTables.
	
	self assert: (referencedTables size = 4).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]
