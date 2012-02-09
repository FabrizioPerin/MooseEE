Class {
	#name : #MJCSPetitSQLiteParser,
	#superclass : #PetitSQLiteASTNodesParser,
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSPetitSQLiteParser >> defaultConstraint [
	
	^default , ( signedNumber / literalValue / '''''' asParser / '""' asParser / 'NULL' asParser trim / ($( asParser trim , expression , $) asParser trim) )
]
