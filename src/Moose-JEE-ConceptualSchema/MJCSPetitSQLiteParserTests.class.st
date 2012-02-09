Class {
	#name : #MJCSPetitSQLiteParserTests,
	#superclass : #PetitSQLiteASTNodesParserTests,
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> parserClass [
	^MJCSPetitSQLiteParser 
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> testDefaultConstraintEmptyWithQuotes [
		
	self
		parse: 'DEFAULT ""'
		rule: #defaultConstraint
]

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParserTests >> testDefaultConstraintEmptyWithSingleQuotes [
		
	self
		parse: 'DEFAULT '''''
		rule: #defaultConstraint
]
