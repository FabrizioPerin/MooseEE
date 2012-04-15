Class {
	#name : #MJCSPetitSQLiteParserTests,
	#superclass : #PetitSQLiteASTNodesParserTests,
	#category : #'Moose-JEE-Tests-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> parserClass [
	^MJCSPetitSQLiteParser 
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> testKey [
		
	self
		parse: 'key'
		rule: #key.
	
	self
		parse: 'kEy '
		rule: #key.
		
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> testTableConstraintPrimaryKeyPartForMYSQLOneColumn [

	self 
		parse: 'key wahtever (column)'
		rule: #tableConstraintPrimaryKeyOrIndexPartForMYSQL.
		
self assert: (result isMemberOf: SQLTableConstraintNode).
	self assert: result isPKConstraint.
	self deny: result isFKConstraint.
	self assert: (result pkColumnNames size = 1).
	self assert: (result pkColumnNames first = 'column').
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> testTableConstraintPrimaryKeyPartForMYSQLTwoColumns [

	self 
		parse: 'key wahtever (column1 , column2)'
		rule: #tableConstraintPrimaryKeyOrIndexPartForMYSQL.
		
self assert: (result isMemberOf: SQLTableConstraintNode).
	self assert: result isPKConstraint.
	self deny: result isFKConstraint.
	self assert: result pkColumnNames size equals:  2.
	self assert: result pkColumnNames first equals: 'column1'.
	self assert: result pkColumnNames second equals: 'column2'.
]
