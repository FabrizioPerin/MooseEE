Class {
	#name : #MJCSSQLImporter,
	#superclass : #MooseSQLiteImporter,
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSSQLImporter >> initialize [
	super initialize.

	sqlASTParser := MJCSPetitSQLiteParser new.
]
