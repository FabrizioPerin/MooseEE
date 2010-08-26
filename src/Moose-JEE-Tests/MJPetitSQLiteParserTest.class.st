Class {
	#name : #MJPetitSQLiteParserTest,
	#superclass : #PetitSQLiteGrammarTest,
	#category : #'Moose-JEE-Tests-PetitSQLParser'
}

{ #category : #accessing }
MJPetitSQLiteParserTest >> parserClass [
	^ MJPetitSQLiteParser
]

{ #category : #running }
MJPetitSQLiteParserTest >> setUp [
	super setUp.
	PPParserResource reset..
	parser := self parserInstance.

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testCreateDatabase [

	super testCreateDatabase.

	self assert: (result isKindOf: MJSQLDataBase).
	self assert: (result name = 'dbName').
	self assert: (result tables isEmpty).

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testCreateTable [

	"super testCreateTable."

	self 
		parse: 'CREATE Table foo as selectStatement'
		rule: #createTable.
	
	self assert: (result isKindOf: MJSQLTable).
	self assert: (result name = 'foo').

	self assert: (result database isKindOf: MJSQLDataBase).
	self assert: (result database name = 'DefaultDBName').

	self assert: (result attributes isKindOf: OrderedCollection ).
	self assert: (result attributes isEmpty ).
	

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testFloatingPointLiteral [

	self 
		parse: '235.43'
		rule: #floatingPointLiteral.
	
	self assert: result = 235.43

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testSignedNumber [

	self 
		parse: '1'
		rule: #signedNumber.
	
	self assert: result = #(1).
	
	self 
		parse: '123'
		rule: #signedNumber.
		
	self assert: result = #(123).
		
	self 
		parse: ' - 1 '
		rule: #signedNumber.
	
	self assert: result = #(-1).
	
	self 
		parse: ' - 123'
		rule: #signedNumber.
	
	self assert: result = #(-123).
	
	self 
		parse: ' 123.23'
		rule: #signedNumber.
	
	self assert: result = #(123.23).

	self 
		parse: ' -123.23'
		rule: #signedNumber.
	
	self assert: result = #(-123.23).
]

{ #category : #tests }
MJPetitSQLiteParserTest >> testTableColumnsDefinition [

	self 
		parse: 'CONFIG_KEY          VARCHAR2(100) NOT NULL,
	CONFIG_VALUE        CLOB NOT NULL,
	CHANGE_DAT          TIMESTAMP,
	VERSION             NUMBER(10) DEFAULT 0 NOT NULL'
		rule: #tableColumnsDefinition.

	self assert: (result isKindOf: MJSQLTable).
	self assert: (result name = 'foo').

	self assert: (result database isKindOf: MJSQLDataBase).
	self assert: (result database name = 'DefaultDBName').

	self assert: (result attributes isKindOf: OrderedCollection ).
	self assert: (result attributes isEmpty ).
	

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testTableConstraint [

	self 
		parse: 'primary key (colName) '
		rule: #tableConstraint.
	
	self 
		parse: 'constraint constName primary key (colName) '
		rule: #tableConstraint.
	self 
		parse: 'constraint constName primary key (colName collate collName asc) '
		rule: #tableConstraint.

	"super testTableConstraint."
	
	self assert: (result isKindOf: MJSQLTable).
	self assert: (result name = 'foo').

	self assert: (result database isKindOf: MJSQLDataBase).
	self assert: (result database name = 'DefaultDBName').

	self assert: (result attributes isKindOf: OrderedCollection ).
	self assert: (result attributes isEmpty ).
	

]

{ #category : #tests }
MJPetitSQLiteParserTest >> testTypeName [

	self 
		parse: ' number (-1235 ,  -235.43 )'
		rule: #typeName.

]
