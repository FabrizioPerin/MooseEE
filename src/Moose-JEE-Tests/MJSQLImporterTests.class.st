Class {
	#name : #MJSQLImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'blackBoard',
		'importer'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewBlackBoardWithTestDB1 [

	| testDB tab1 col11 col12 col13 tab2 col21 col22 col23 tab3 col31 col32 col33 |
	
	testDB := PetitSQLDataBase new name: 'testDB1'.
	"add the database"
	blackBoard addDatabase: testDB.
	
	"DEFINITION OF TABLE 1"
	tab1 := self createNewTableNamed: 'Tab1'.
	
	col11 := self createNewColumnNamed: 'Col1Tab1' whichTypeIs: 'Integer'.
	col11 defaultValue: 0.
	
	col12 := self createNewColumnNamed: 'Col2Tab1' whichTypeIs: 'Integer'.
	col12 isPK: true.
	
	col13 :=  self createNewColumnNamed: 'Col3Tab1' whichTypeIs: 'Integer'.
	col13 isPK: true.
	
	tab1 columns addAll: blackBoard columns.
	blackBoard columns do: [:each | each table: tab1 ].
	
	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	col21 table: tab2.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'String'.
	col21 table: tab2.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'VarChar'.
	col21 table: tab2.

	tab2 columns add: col21.
	tab2 columns add: col22.
	tab2 columns add: col23.
	blackBoard columns do: [:each | each table: tab2 ].
	
	"add tables to the db"
	blackBoard tables do: [:tab | testDB addTable: tab].
	

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewBlackBoardWithTestDBWithFKs [
	| testDB tab1 col11 col12 col13 tab2 col21 col22 col23 tab3 col31 col32 col33 constr |
	
	testDB := PetitSQLDataBase new name: 'testDB1'.
	"add the database"
	blackBoard addDatabase: testDB.
	

	"DEFINITION OF TABLE 1"
	tab1 := self createNewTableNamed: 'Tab1'.
	
	col11 := self createNewColumnNamed: 'Col1Tab1' whichTypeIs: 'Integer'.
	col11 defaultValue: 0.
	
	col12 := self createNewColumnNamed: 'Col2Tab1' whichTypeIs: 'Integer'.
	col12 isPK: true.
	
	col13 :=  self createNewColumnNamed: 'Col3Tab1' whichTypeIs: 'Integer'.
	col13 isPK: true.
	
	tab1 columns addAll: blackBoard columns.
	blackBoard columns do: [:each | each table: tab1 ].	
	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	col21 table: tab2.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'String'.
	col22 table: tab2.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'VarChar'.
	col23 table: tab2.

	tab2 columns add: col21.
	tab2 columns add: col22.
	tab2 columns add: col23.
	blackBoard columns do: [:each | each table: tab2 ].
	
	"DEFINITION OF TABLE 3"
	tab3 := self createNewTableNamed: 'Tab3'.
	
	col31 := self createNewColumnNamed: 'Col1Tab3' whichTypeIs: 'Integer'.
	col31 defaultValue: 0.
	col31 table: tab3.
	
	col32 := self createNewColumnNamed: 'Col2Tab3' whichTypeIs: 'Integer'.
	col32 table: tab3.
	
	col33 :=  self createNewColumnNamed: 'Col3Tab3' whichTypeIs: 'Integer'.
	col33 table: tab3.
	
	tab3 columns add: col31.
	tab3 columns add: col32.
	tab3 columns add: col33.

	"add tables to the db"
	blackBoard tables do: [:tab | testDB addTable: tab].

	"Creating foreign keys references"
	constr := self 
		createNewFKConstraintNamed: 'Constr1' 
		between: (OrderedCollection with: tab3 with: col32 with: col33 ) 
		and:  (OrderedCollection with: tab1 with: col12 with: col13 ).

	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewBlackBoardWithTestDBWithPKs [
	| testDB tab1 col11 col12 col13 tab2 col21 col22 col23 tab3 col31 col32 col33 constr |
	
	testDB := PetitSQLDataBase new name: 'testDB1'.
	"add the database"
	blackBoard addDatabase: testDB.
	

	"DEFINITION OF TABLE 1"
	tab1 := self createNewTableNamed: 'Tab1'.
	
	col11 := self createNewColumnNamed: 'Col1Tab1' whichTypeIs: 'Integer'.
	col11 defaultValue: 0.
	
	col12 := self createNewColumnNamed: 'Col2Tab1' whichTypeIs: 'Integer'.
	
	col13 :=  self createNewColumnNamed: 'Col3Tab1' whichTypeIs: 'Integer'.
	
	tab1 columns addAll: blackBoard columns.
	blackBoard columns do: [:each | each table: tab1 ].

	
	"add tables to the db"
	blackBoard tables do: [:tab | testDB addTable: tab].

	"Creating foreign keys references"
	constr := self 
		createNewPKConstraintNamed: 'Constr1' 
		for: tab1
		and:  (OrderedCollection with: col12 with: col13 ).

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewColumnNamed: aString whichTypeIs: aTypeName [
	| column |

	column := PetitSQLColumn new 
					name: aString;
					type: aTypeName.
					
	blackBoard addColumn: column.
	"blackBoard addToRecentColumnGroup: column."
								
	^column
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewFKConstraintNamed: aString between: aCollectionWithaTableAndOfColumns and: anotherCollectionWithaTableAndOfColumns [
	
	| constr |
	constr := PetitSQLConstraints new name: aString.
	
	constr isFKConstraint: true.
	constr isPKConstraint: false.
	
	aCollectionWithaTableAndOfColumns do: [:each |
		(aCollectionWithaTableAndOfColumns first = each) 
			ifTrue: [aCollectionWithaTableAndOfColumns first addConstraint: constr]
			ifFalse: [
				constr addFKColumnName: each name.
				each isFK: true.]
	].
	
	anotherCollectionWithaTableAndOfColumns do: [:each |
		(anotherCollectionWithaTableAndOfColumns first = each) 
			ifTrue: [constr referencedTableName: anotherCollectionWithaTableAndOfColumns first name.]
			ifFalse: [constr addPKColumnName: each name.]
	].

	^constr
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewPKConstraintNamed: aString for: aTable and: aCollectionOfColumns [
	| constr |
	constr := PetitSQLConstraints new name: aString.
	
	constr isFKConstraint: false.
	constr isPKConstraint: true.
	
	aTable addConstraint: constr.
	
	aCollectionOfColumns do: [:each | constr addPKColumnName: each name].
	
	^constr 
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewTableNamed: aString [

	| dbTable |
	
	dbTable := PetitSQLTable
			name: aString
			ownedBy: blackBoard databases last.
		
	blackBoard addTable: dbTable.
	
	^dbTable
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewTestDB1 [

	| testDB tab1 col11 col12 col13 tab2 col21 col22 col23 tab3 col31 col32 col33 |
	
	testDB := PetitSQLDataBase new name: 'testDB1'.

	"DEFINITION OF TABLE 1"
	tab1 := self createNewTableNamed: 'Tab1'.
	
	col11 := self createNewColumnNamed: 'Col1Tab1' whichTypeIs: 'Integer'.
	col11 defaultValue: 0.
	
	col12 := self createNewColumnNamed: 'Col2Tab1' whichTypeIs: 'Integer'.
	col12 isPK: true.
	
	col13 :=  self createNewColumnNamed: 'Col3Tab1' whichTypeIs: 'Integer'.
	col13 isPK: true.
	
	tab1 attributes addAll: blackBoard columns.
	blackBoard columns do: [:each | each table: tab1 ].

	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	col21 table: tab2.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'String'.
	col22 table: tab2.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'VarChar'.
	col23 table: tab2.

	tab2 columns add: col21.
	tab2 columns add: col22.
	tab2 columns add: col23.
	blackBoard columns do: [:each | each table: tab2 ].
	
	"DEFINITION OF TABLE 3"
	tab3 := self createNewTableNamed: 'Tab3'.
	
	col31 := self createNewColumnNamed: 'Col1Tab3' whichTypeIs: 'Integer'.
	col31 defaultValue: 0.
	col31 table: tab3.
	
	col32 := self createNewColumnNamed: 'Col2Tab3' whichTypeIs: 'Integer'.
	col32 table: tab3.
	
	col33 :=  self createNewColumnNamed: 'Col3Tab3' whichTypeIs: 'Integer'.
	col33 table: tab3.
	
	tab3 columns add: col31.
	tab3 columns add: col32.
	tab3 columns add: col33.
	
	"Creating foreign keys references"
	
	col33 isFK: true.
	col33 references: col13.
	
	col32 isFK: true.
	col32 references: col12.
	
		
	"add the database"
	blackBoard addDatabase: testDB.
	

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> setUp [

	blackBoard := PetitSQLiteParserBlackBoard new.
	importer := MJSQLImporter new.
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> tearDown [

	blackBoard := nil.
	importer := nil.
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateAColumnFrom [
	| col1 colInstance |
	
	col1 := self createNewColumnNamed: 'Col1' whichTypeIs: 'Integer'.
	
	self assert: (col1 isKindOf: PetitSQLColumn).
	self assert: (col1 name = 'Col1').
	self assert: (col1 type = 'Integer').
		
	colInstance := importer instanciateAColumnFrom: col1.
	
	self assert: (colInstance isKindOf: MJFAMIXColumn ).
	self assert: (colInstance name = 'Col1').
	self assert: (colInstance type = 'Integer').
	
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseFrom [

	| dbDraftObj db |
	
	self createNewBlackBoardWithTestDB1.
		
	self assert: (blackBoard databases size = 1).
	self assert: (blackBoard databases first name = 'testDB1').
	
	dbDraftObj := blackBoard databases first.
	
	db := importer instanciateADataBaseFrom: dbDraftObj.
	
	self assert: (db isKindOf: MJFAMIXDataBase).
	self assert: (db name = 'testDB1').
	self assert: (db tables size = 2).
	self assert: (db tables allSatisfy: [:tab | tab isKindOf: MJFAMIXTable]).
	
	
	self assert: ((db tables flatCollect: [:tab | tab columns]) size = 6).
	self assert: ((db tables flatCollect: [:tab | tab columns]) allSatisfy: [:col | col isKindOf: MJFAMIXColumn ]).
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseFromWithConstraints [

	| dbDraftObj db tabelWithConstraint referencedTable constr famixGeneratedTable |
	
	self createNewBlackBoardWithTestDBWithFKs.
		
	self assert: (blackBoard databases size = 1).
	self assert: (blackBoard databases first name = 'testDB1').
	
	dbDraftObj := blackBoard databases first.
	
	db := importer instanciateADataBaseFrom: dbDraftObj.
	
	self assert: (db isKindOf: MJFAMIXDataBase).
	self assert: (db name = 'testDB1').
	self assert: (db tables size = 3).
	self assert: (db tables allSatisfy: [:tab | tab isKindOf: MJFAMIXTable]).
	
	self assert: ((db tables flatCollect: [:tab | tab columns]) size = 9).
	self assert: ((db tables flatCollect: [:tab | tab columns]) allSatisfy: [:col | col isKindOf: MJFAMIXColumn ]).
	
	tabelWithConstraint := (dbDraftObj tables select: [:tab | tab constraints size > 0]) first.
	constr := tabelWithConstraint constraints first.
	
	self assert: (tabelWithConstraint name = 'Tab3').
	
	famixGeneratedTable := (db tables select: [:tab | tab name = tabelWithConstraint name]) first.
	
	self assert: ((famixGeneratedTable columns select: [:col | col name = 'Col3Tab3']) first isFK ).
	self assert: ((famixGeneratedTable columns select: [:col | col name = 'Col2Tab3']) first isFK ).
	self assert: (constr referencedTableName = 'Tab1').
	self assert: (constr pkColumnNames size = 2).

	referencedTable := (db tables select: [:tab | tab name = constr referencedTableName ]) first.
	
	self assert: (referencedTable columns anySatisfy: [:col | col name =  constr pkColumnNames first.]).
	self assert: (referencedTable columns anySatisfy: [:col | col name =  constr pkColumnNames second]).
	
	self assert: ((referencedTable columns select: [:col | col name = constr pkColumnNames first ]) first isPK).
	self assert: ((referencedTable columns select: [:col | col name = constr pkColumnNames  second ]) first isPK).

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseTableFrom [

	| tab  tabInstance |
	
	blackBoard addDatabase: (PetitSQLDataBase new name: 'testDB1').
	tab := self createNewTableNamed: 'table1'.
	
	self assert: (tab isKindOf: PetitSQLTable).
	self assert: (tab name = 'table1').
		
	tabInstance := importer instanciateADataBaseTableFrom: tab.

	self assert: (tabInstance isKindOf: MJFAMIXTable).
	self assert: (tabInstance name = 'table1').
	self assert: (tabInstance columns size = 0).
	
	
	
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseTableFromWithPKConstraints [

	| tab  tabInstance |
	
	self createNewBlackBoardWithTestDBWithPKs.
	
	self assert: (blackBoard tables size = 1).
	self assert: (blackBoard tables first constraints size = 1).
	self assert: (blackBoard columns size = 3).	
		
	tabInstance := importer instanciateADataBaseTableFrom: (blackBoard tables first).

	self assert: (tabInstance isKindOf: MJFAMIXTable).
	self assert: (tabInstance name = 'Tab1').
	self assert: (tabInstance columns size = 3).
	
	self assert: ((tabInstance columns select: [:col | col name = 'Col2Tab1'] ) first isPK).
	self assert: ((tabInstance columns select: [:col | col name = 'Col3Tab1'] ) first isPK).
	
	self assert: ((tabInstance columns select: [:col | col name = 'Col2Tab1'] ) first isFK isNil).
	self assert: ((tabInstance columns select: [:col | col name = 'Col3Tab1'] ) first isFK isNil).
	
	
	
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testPopulateWithRelationalElementsFrom [

	| model dbInst table3 col2Tab1 col2Tab3 col3Tab1 col3Tab3 table1|
	
	model := MooseModel new.
	
	self createNewBlackBoardWithTestDBWithFKs.
	
	importer populate: model withRelationalElementsFrom: blackBoard.
	
	self assert: (model allDatabases size = 1).
	self assert: (model allDatabases first name = 'testDB1').
	self assert: (model allTables size = 3).
	self assert: (model allColumns size = 9).
	
	dbInst := model allDatabases first.
	self assert: (dbInst tables size = 3).
	self assert: (dbInst tables allSatisfy: [:tab | tab isKindOf: MJFAMIXTable]).	
	
	table1 := (dbInst tables select: [:tab | tab name = 'Tab1']) first.
	table3 := (dbInst tables select: [:tab | tab name = 'Tab3']) first.
	
	self assert: (table3 columns size = 3).
	self assert: (table3 columns allSatisfy: [:col | col isKindOf: MJFAMIXColumn]).
	self assert: (table1 columns size = 3).
	self assert: (table1 columns allSatisfy: [:col | col isKindOf: MJFAMIXColumn]).
	
	col2Tab3 := (table3 columns select: [:col | col name = 'Col2Tab3']) first.
	col3Tab3 := (table3 columns select: [:col | col name = 'Col3Tab3']) first.
	
	self assert: col2Tab3 isFK.
	self assert: col3Tab3 isFK.
	
	col2Tab1 := (table1 columns select: [:col | col name = 'Col2Tab1']) first.
	col3Tab1 := (table1 columns select: [:col | col name = 'Col3Tab1']) first.
	
	self assert: col2Tab1 isPK.
	self assert: col3Tab1 isPK.
	
	self assert: (col2Tab3 references size = 1).
	self assert: ( col2Tab3 references first isKindOf: MJFAMIXFKAssociation).
	self assert: (col2Tab3 references first targetTable = col2Tab1).
	
	self assert: (col3Tab3 references size = 1).
	self assert: (col3Tab3 references first isKindOf: MJFAMIXFKAssociation).
	self assert: (col3Tab3 references first targetTable = col3Tab1).
	
	self assert: (model allFKAssociations size = 2).
	self assert: ((model allWithType: MJFAMIXFKAssociation) size = model allFKAssociations size).
	 
]
