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
				type: 'integer'.
	
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
