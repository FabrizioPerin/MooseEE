Class {
	#name : #MJPetitSQLiteParserTest,
	#superclass : #PetitSQLiteGrammarTest,
	#category : #'Moose-JEE-Tests-PetitSQLParser'
}

{ #category : #'as yet unclassified' }
MJPetitSQLiteParserTest >> testCreateDatabase [
	"result should be = #('CREATE DATABASE' 'diProva' $;)"
	super testCreateDatabase.
	
	self assert: result isArray.
	self assert: (result size = 3).
	self assert: (result first = 'CREATE DATABASE').
	self assert: (result second = 'diProva').
	self assert: (result third = $;).
]
