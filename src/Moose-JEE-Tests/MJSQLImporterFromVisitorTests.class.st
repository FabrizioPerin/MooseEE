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
				constraints: #().
	
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
				constraints: (Array with: const).
	
	famixCol := importer ensureAColumn: col.
	
	self assert: (famixCol isMemberOf: MJFAMIXColumn).
	self assert: (famixCol name = #col1).
	self assert: (famixCol type = 'integer').
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
