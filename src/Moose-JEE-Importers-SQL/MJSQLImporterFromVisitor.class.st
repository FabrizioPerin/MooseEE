Class {
	#name : #MJSQLImporterFromVisitor,
	#superclass : #Object,
	#instVars : [
		'sqlASTParser'
	],
	#category : #'Moose-JEE-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureATable: aTableNode [
	self halt.
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> importSQLCreateScriptFrom: aStream AMooseModel: aMooseModel [
	| sqlScriptNodes scriptNode visitor |
	
	sqlScriptNodes := self sqlASTParser parse: aStream.
	
	visitor := (SQLASTVisitor new) importer: self.
	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> populate: aMooseModel withRelationalElementsFrom: aBlackBoard [

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
				
			bar value: 'Computing foreign keys constraints'.
			
			aBlackBoard databases do: [:aDBRepresentation | 
				aMooseModel withoutAnnounceAddAll: (self computeForeignKeysFor: dataBases first tables from: aDBRepresentation tables )].
			].
	
	^aMooseModel
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> sqlASTParser [
	^ sqlASTParser ifNil: [sqlASTParser := PetitSQLiteASTNodesParser new]
]
