Class {
	#name : #MJSQLImporterFromVisitorTests,
	#superclass : #TestCase,
	#instVars : [
		'sqlASTParser',
		'targetModel',
		'tables',
		'columns'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureAColumn [
	| importer col famixCol |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	famixCol := importer ensureAColumn: col.
	
	self assert: (famixCol isMemberOf: MJFAMIXColumn).
	self assert: (famixCol name = #col1).
	self assert: (famixCol type = 'integer').
]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureAColumnWithConstraints [
	| importer col famixCol const |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	const := SQLColumnConstraintNode new
					defaultValue: 0;
					isPK: true;
					canBeNull: false;
					isUnique: nil.
					
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: const.
	
	famixCol := importer ensureAColumn: col.
	
	self assert: (famixCol isMemberOf: MJFAMIXColumn).
	self assert: (famixCol name = #col1).
	self assert: (famixCol type = 'integer').
]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureATable [
	| importer tab famixTab |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: #();
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: MJFAMIXTable).
	self assert: (famixTab name = #tab1).

]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureATableWithColumns [
	| importer tab famixTab col |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: MJFAMIXTable).
	self assert: (famixTab name = #tab1).
	self assert: (famixTab columns size = 1).
	self assert: (famixTab columns first name = #col1).
	self assert: (famixTab columns first type = 'integer').
	
	  

]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureATableWithColumnsAndConstraints [
	| importer tab famixTab |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: #();
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: MJFAMIXTable).
	self assert: (famixTab name = #tab1).

]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testEnsureATableWithColumnsAndConstrant [
	| importer tab famixTab col const |
	
	importer :=  MJSQLImporterFromVisitor new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	const := SQLTableConstraintNode new
					isPKConstraint: true;
					addPKColumnName: #col1.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: (Array with: const).
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: MJFAMIXTable).
	self assert: (famixTab name = #tab1).
	self assert: (famixTab columns size = 1).
	self assert: (famixTab columns first name = #col1).
	self assert: (famixTab columns first type = 'integer').
	
	  

]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testSqlASTParser [
	
	| importer |
	importer := MJSQLImporterFromVisitor new.

	self assert: (importer sqlASTParser hash = importer sqlASTParser hash).   
	self assert: (importer sqlASTParser isMemberOf: PetitSQLiteASTNodesParser).
]

{ #category : #accessing }
MJSQLImporterFromVisitorTests >> testTargetModel [
	
	| mm importer |
	
	mm := MooseModel new.
	
	importer := MJSQLImporterFromVisitor new targetModel: mm.
	
	self assert: (importer targetModel = mm).
]
