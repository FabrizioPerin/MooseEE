Class {
	#name : #MJSQLImporter,
	#superclass : #Object,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporter >> computeForeignKeysFor: dbTables from: aDraftObjectTableGroup [

	dbTables do: [:table |
		aDraftObjectTableGroup do: [:draftTable |
			(table name = draftTable name) ifTrue: [
				draftTable constraints do: [:constr |
					constr isFKConstraint ifTrue: [
						| referencedTable |
						referencedTable := (dbTables select: [:refTable | refTable name = constr referencedTableName]) first.
						"set as foreign key the columns of the table having the constraint"
						(1 to: (constr pkColumnsName size)) do: [:index |
							| tableColumn |
							tableColumn := 	(table columns select: [:col | col name = (constr fkColumnsName at: index)]) first.
							tableColumn isFK: true.
							tableColumn references: (referencedTable columns select: [:col | col name = (constr pkColumnsName at: index)] )first.
						]
					]
				]
			]
		]
	]
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateAColumnFrom: aDraftObject [
	
	
	| att |
	
	att := MJFAMIXColumn new.
	att name: aDraftObject name.
	att type: aDraftObject type.
	att isFK: aDraftObject isFK.
	att isPK: aDraftObject isPK.
	
	^att
	
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateADataBaseFrom: aDraftObject [
		
	| dB |
	
	dB := MJFAMIXDataBase new.
	dB name: aDraftObject name.
	dB tables: (aDraftObject tables collect: [:aTableRepresentation | self instanciateADataBaseTableFrom: aTableRepresentation ]).
	
	self computeForeignKeysFor: dB tables from: aDraftObject tables.
		
	^dB
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateADataBaseTableFrom: aDraftObjectTable [
	
	| tab |
	
	tab := MJFAMIXTable new.
	tab name: aDraftObjectTable name.
	tab columns: (aDraftObjectTable columns collect: [:aColumnRepresentation | self instanciateAColumnFrom: aColumnRepresentation ]).   
	
	"setting up the primary keys"
	aDraftObjectTable constraints isEmpty
		ifFalse: [
			aDraftObjectTable constraints do: [:constraint | 
				constraint isPKConstraint ifTrue: [constraint pkColumnsName do: [:attNames |
						(tab columns select: [:col | col name = attNames]) first isPK: true]
				].
			].
		].
	
	^tab
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> populate: aMooseModel withRelationalElementsFrom: aBlackBoard [

	| dataBases |
	
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
		
			bar value: 2.
			bar value: 'Instantiating  the data base'.
			
			dataBases := aBlackBoard databases collect: [:aDBRepresentation | self instanciateADataBaseFrom: aDBRepresentation ].
			aMooseModel addAll: dataBases.
			
			bar value: 3.
			bar value: 'Instantiating the tables'.
			
			aMooseModel addAll: (dataBases flatCollect: [:each | each tables ]).
	
			bar value: 4.
			bar value: 'Instantiating the attributes'.
	
			aMooseModel addAll: (aMooseModel allTables flatCollect: [:table | table columns ]).
			
			bar value: 5].
	
	^aMooseModel
]
