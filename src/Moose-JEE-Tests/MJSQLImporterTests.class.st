Class {
	#name : #MJSQLImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'blackBoard'
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
	
	tab1 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab1 ].
	blackBoard clearLatestAttributesGroup.
	
	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'String'.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'VarChar'.
	
	tab2 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab2 ].
	blackBoard clearLatestAttributesGroup.
	
	"add tables to the db"
	blackBoard tables do: [:tab | testDB addTable: tab].
	

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewBlackBoardWithTestDBWithPKsAndFKs [
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
	
	tab1 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab1 ].
	blackBoard clearLatestAttributesGroup.
	
	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'Integer'.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'Integer'.
	
	tab2 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab2 ].
	blackBoard clearLatestAttributesGroup.
	
	
	"DEFINITION OF TABLE 3"
	tab3 := self createNewTableNamed: 'Tab3'.
	
	col31 := self createNewColumnNamed: 'Col1Tab3' whichTypeIs: 'Integer'.
	col31 defaultValue: 0.
	
	col32 := self createNewColumnNamed: 'Col2Tab3' whichTypeIs: 'Integer'.
	
	col33 :=  self createNewColumnNamed: 'Col3Tab3' whichTypeIs: 'Integer'.

	
	tab3 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab3].
	blackBoard clearLatestAttributesGroup.

	"add tables to the db"
	blackBoard tables do: [:tab | testDB addTable: tab].

	"Creating foreign keys references"
	constr := self 
		createNewFKConstraintNamed: 'Constr1' 
		between: (OrderedCollection with: tab3 with: col32 with: col33 ) 
		and:  (OrderedCollection with: tab1 with: col12 with: col13 ).

	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> createNewColumnNamed: aString whichTypeIs: aTypeName [
	| column |

	column := PetitSQLAttributes new 
					name: aString;
					type: aTypeName.
					
	blackBoard addAttribute: column.
	blackBoard addToRecentAttributeGroup: column.
								
	^column
				"colDef third second do: [:colConstraint |
							(colConstraint first match: 'default') ifTrue: [column defaultValue: colConstraint second first].
							(colConstraint first match: 'primary key') ifTrue: [column isPK: true].
							(colConstraint first match: 'not null') ifTrue: [column canBeNull: false.].
							(colConstraint first match: 'unique') ifTrue: [column isUnique: true].
									].
				blackBoard addAttribute: column.
				blackBoard addToRecentAttributeGroup: column.
				column.]]]"
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
				constr addFKAttributeName: each name.
				each isFK: true.]
	].
	
	anotherCollectionWithaTableAndOfColumns do: [:each |
		(anotherCollectionWithaTableAndOfColumns first = each) 
			ifTrue: [constr referencedTableName: anotherCollectionWithaTableAndOfColumns first name.]
			ifFalse: [constr addPKAttributeName: each name.]
	].

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
	
	tab1 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab1 ].
	blackBoard clearLatestAttributesGroup.
	
	
	"DEFINITION OF TABLE 2"
	tab2 := self createNewTableNamed: 'Tab2'.
	
	col21 := self createNewColumnNamed: 'Col1Tab2' whichTypeIs: 'Integer'.
	col21 defaultValue: 0.
	
	col22 := self createNewColumnNamed: 'Col2Tab2' whichTypeIs: 'Integer'.
	
	col23 :=  self createNewColumnNamed: 'Col3Tab2' whichTypeIs: 'Integer'.
	
	tab2 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab2 ].
	blackBoard clearLatestAttributesGroup.
	
	"DEFINITION OF TABLE 3"
	tab3 := self createNewTableNamed: 'Tab3'.
	
	col31 := self createNewColumnNamed: 'Col1Tab3' whichTypeIs: 'Integer'.
	col31 defaultValue: 0.
	
	col32 := self createNewColumnNamed: 'Col2Tab3' whichTypeIs: 'Integer'.
	
	col33 :=  self createNewColumnNamed: 'Col3Tab3' whichTypeIs: 'Integer'.

	
	tab3 attributes addAll: blackBoard latestAttributesGroup.
	blackBoard latestAttributesGroup do: [:each | each table: tab3].
	blackBoard clearLatestAttributesGroup.

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
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateAColumnFrom [
	| col1 colInstance importer |
	
	col1 := self createNewColumnNamed: 'Col1' whichTypeIs: 'Integer'.
	
	self assert: (col1 isKindOf: PetitSQLAttributes).
	self assert: (col1 name = 'Col1').
	self assert: (col1 type = 'Integer').
		
	importer := MJSQLImporter new.
	
	colInstance := importer instanciateAColumnFrom: col1.
	
	self assert: (colInstance isKindOf: MJFAMIXColumn ).
	self assert: (colInstance name = 'Col1').
	self assert: (colInstance type = 'Integer').
	
	
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseFrom1 [

	| dbDraftObj db |
	
	self createNewBlackBoardWithTestDB1.
		
	self assert: (blackBoard databases size = 1).
	self assert: (blackBoard databases first name = 'testDB1').
	
	dbDraftObj := blackBoard databases first.
	
	db := MJSQLImporter new instanciateADataBaseFrom: dbDraftObj.
	
	self assert: (db isKindOf: MJFAMIXDataBase).
	self assert: (db name = 'testDB1').
	self assert: (db tables size = 2).
	self assert: (db tables allSatisfy: [:tab | tab isKindOf: MJFAMIXTable]).
	
	
	self assert: ((db tables flatCollect: [:tab | tab columns]) size = 6).
	self assert: ((db tables flatCollect: [:tab | tab columns]) allSatisfy: [:col | col isKindOf: MJFAMIXColumn ]).
]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseFrom2 [

	| dbDraftObj db tabelWithConstraint referencedTable constr famixGeneratedTable |
	
	self createNewBlackBoardWithTestDBWithPKsAndFKs.
		
	self assert: (blackBoard databases size = 1).
	self assert: (blackBoard databases first name = 'testDB1').
	
	dbDraftObj := blackBoard databases first.
	
	db := MJSQLImporter new instanciateADataBaseFrom: dbDraftObj.
	
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
	self assert: (constr pkAttributeNames size = 2).

	referencedTable := (db tables select: [:tab | tab name = constr referencedTableName ]) first.
	
	self assert: (referencedTable columns anySatisfy: [:col | col name =  constr pkAttributeNames first.]).
	self assert: (referencedTable columns anySatisfy: [:col | col name =  constr pkAttributeNames second]).
	
	self assert: ((referencedTable columns select: [:col | col name = constr pkAttributeNames first ]) first isPK).
	self assert: ((referencedTable columns select: [:col | col name = constr pkAttributeNames second ]) first isPK).

]

{ #category : #'as yet unclassified' }
MJSQLImporterTests >> testInstanciateADataBaseTableFrom [

	| tab importer tabInstance |
	
	blackBoard addDatabase: (PetitSQLDataBase new name: 'testDB1').
	tab := self createNewTableNamed: 'table1'.
	
	self assert: (tab isKindOf: PetitSQLTable).
	self assert: (tab name = 'table1').
	
	importer := MJSQLImporter new.
	
	tabInstance := importer instanciateADataBaseTableFrom: tab.

	self assert: (tabInstance isKindOf: MJFAMIXTable).
	self assert: (tabInstance name = 'table1').
	self assert: (tabInstance columns size = 0).
	
	
	
	
	
]
