Class {
	#name : #MJSQLImporter,
	#superclass : #Object,
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporter >> computeForeignKeysFor: dbTables from: aDraftObjectTableGroup [

	| fkAssociations |
	
	fkAssociations := OrderedCollection new.

	dbTables do: [:table |
		aDraftObjectTableGroup do: [:draftTable |
			(table name = draftTable name) ifTrue: [ " table contain the db table with the foreign keys"
				draftTable constraints do: [:constr |
					(constr isArray not and: [constr isFKConstraint]) ifTrue: [
						| referencedTable |
						referencedTable := (dbTables select: [:refTable | refTable name = constr referencedTableName]) first.
						"set as foreign key the columns of the table having the constraint"
						(1 to: (constr pkColumnNames size)) do: [:index |
							| tableColumn referencedTableColumn fkAssoc |
							tableColumn := 	(table columns select: [:col | col name = (constr fkColumnsName at: index)]) first.
							referencedTableColumn := (referencedTable columns select: [:col | col name = (constr pkColumnNames at: index)] )first.
							tableColumn isFK: true.
							
							"creation of the association"	
							fkAssoc := MJFAMIXFKAssociation new targetTable: referencedTableColumn; sourceTable: tableColumn.
							referencedTableColumn addReferencedBy: fkAssoc.
							tableColumn addReferences: fkAssoc.
							
							fkAssociations add: fkAssoc.							
						]
					]
				]
			]
		]
	].

	^fkAssociations.
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
MJSQLImporter >> instanciateADataBaseFrom: aDraftDataBaseObject [
		
	| dB |
	
	dB := MJFAMIXDataBase new.
	dB name: aDraftDataBaseObject name.
	dB tables: (aDraftDataBaseObject tables collect: [:aTableRepresentation | self instanciateADataBaseTableFrom: aTableRepresentation ]).
	
	^dB
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> instanciateADataBaseTableFrom: aDraftObjectTable [
	
	| tab |
	
	tab := MJFAMIXTable new.
	tab name: aDraftObjectTable name.
	tab columns: (aDraftObjectTable columns collect: [:aColumnRepresentation | self instanciateAColumnFrom: aColumnRepresentation ]).   
	
	"setting up the primary keys"
	aDraftObjectTable constraints do: [:constraint | 
		((constraint isArray not) and: [constraint isPKConstraint]) ifTrue: [constraint pkColumnNames do: [:attNames |
				(tab columns select: [:col | col name = attNames]) first isPK: true]]].
	
	^tab
]

{ #category : #'as yet unclassified' }
MJSQLImporter >> populate: aMooseModel withRelationalElementsFrom: aBlackBoard [

	| dataBases columns tables counter |
	
	dataBases := aBlackBoard databases collect: [:aDBRepresentation | self instanciateADataBaseFrom: aDBRepresentation ].
	tables := dataBases flatCollect: [:each | each tables ].
	columns := tables flatCollect: [:table | table columns ].
	
	counter := 1.
	
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: (tables size + columns size)
		during: [ :bar | 
		
			counter := counter + 1.
			bar value: counter.
			bar value: 'Adding data base'.
			
			aMooseModel addAll: dataBases.

			bar value: ('Adding ', tables size asString ,' tables').
			tables do: [:table | 
				aMooseModel withoutAnnounceAdd: table.
				counter := counter + 1.
				bar value: counter].
			
			bar value: ('Adding' , columns size asString , 'attributes').
	
			columns do: [:col |
				aMooseModel withoutAnnounceAdd: col.
				counter := counter + 1.
				bar value: counter].	
				
			"connect columns and tables"
			aMooseModel allTables do: [:table | table columns do: [:col | col ownerTable: table]].
			
			bar value: 'Computing foreign keys constraints'.
			
			aBlackBoard databases do: [:aDBRepresentation | 
				aMooseModel withoutAnnounceAddAll: (self computeForeignKeysFor: dataBases first tables from: aDBRepresentation tables )].
			].
	
	^aMooseModel
]
