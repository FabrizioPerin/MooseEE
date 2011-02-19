Class {
	#name : #MJSQLImporterFromVisitor,
	#superclass : #Object,
	#instVars : [
		'sqlASTParser',
		'targetModel',
		'tables',
		'columns',
		'sqlASTVisitor'
	],
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> computeForeignKeysFor: dbTables from: aDraftObjectTableGroup [

	| fkAssociations |
	
	self flag: 'TODO: to remove'.
	
	fkAssociations := OrderedCollection new.

	dbTables do: [:table |
		aDraftObjectTableGroup do: [:draftTable |
			(table name = draftTable name) ifTrue: [ " table contain the db table with the foreign keys"
				draftTable constraints do: [:constr |
					(constr isArray not and: [constr isFKConstraint]) ifTrue: [
						| referencedTable |
						referencedTable := (dbTables select: [:refTable | refTable name = constr referencedTableName]) first.
						"set as foreign key the columns of the table having the constraint"
						(1 to: (constr pkColumnsName size)) do: [:index |
							| tableColumn referencedTableColumn fkAssoc |
							tableColumn := 	(table columns select: [:col | col name = (constr fkColumnsName at: index)]) first.
							referencedTableColumn := (referencedTable columns select: [:col | col name = (constr pkColumnsName at: index)] )first.
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
MJSQLImporterFromVisitor >> ensureAColumn: anASTColumnNode [
	| att constraint |
	
	att := MJFAMIXColumn new.
	att name: anASTColumnNode name.
	att type: anASTColumnNode type.
	
	constraint := anASTColumnNode constraints.
	
	constraint isNil not ifTrue: [
							att defaultValue: constraint defaultValue.
							att isUnique: constraint isUnique.
							att canBeNull: constraint canBeNull.
							att isPK: constraint isPK].

	^att
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureAColumnConstraint: aColumnConstraintNode [
	| att |
	self flag: #todo remove.
	
	^att
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureATable: aTableNode [
	
	| tab |

	tab := MJFAMIXTable new name: aTableNode name.
	tab columns: (aTableNode columns collect: [:aColumnNode | aColumnNode accept: sqlASTVisitor]).   

	"setting up the primary keys"
	aTableNode constraints do: [:aConstraintNode |
			| constraint |
			constraint :=  aConstraintNode accept: sqlASTVisitor.
			constraint isPKConstraint ifTrue: [aConstraintNode pkColumnsName do: [:attNames |
				(tab columns select: [:col | col name = attNames]) first isPK: true]]].
		
	^tab
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureTableConstraintNode: aTableConstraintNode [
	| newConstr |
	newConstr := PetitSQLConstraints new.

	newConstr isPKConstraint: aTableConstraintNode isPKConstraint.
	newConstr isFKConstraint: aTableConstraintNode isFKConstraint.
		
	newConstr isPKConstraint ifTrue: [newConstr pkColumnsName do: [:each | newConstr addPKColumnName: each ]].
	
	^newConstr
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> importSQLCreateScriptFrom: aStream [
	| sqlScriptNodes scriptNode |
	
	sqlScriptNodes := (sqlASTParser parse: aStream) deepFlatten.
	

	
	self populateTargetModelWith: (sqlScriptNodes collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: sqlASTVisitor]]).
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> initialize [
	super initialize.
	
	sqlASTVisitor := SQLASTConcreteVisitor new importer: self.
	sqlASTParser := PetitSQLiteASTNodesParser new
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> populateTargetModelWith: aCollectionOfEnsuredNodes [

	| dataBases counter aMooseModel aBlackBoard |
	
	self halt.
	
	dataBases := aCollectionOfEnsuredNodes databases collect: [:aDBRepresentation | self instanciateADataBaseFrom: aDBRepresentation ].
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

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> sqlASTParser [
	^ sqlASTParser
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> sqlASTVisitor [
	^ sqlASTVisitor
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> targetModel: anObject [
	targetModel := anObject
]
