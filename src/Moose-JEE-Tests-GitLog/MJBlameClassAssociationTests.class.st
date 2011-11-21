Class {
	#name : #MJBlameClassAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-GitLog'
}

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testCreation [
	| assoc |
	assoc := MJBlameClassAssociation new.
	
	self assert: (assoc isMemberOf: MJBlameClassAssociation).
	

]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testCreationWithAssociations [

	| bf john bl1 bl2 class assoc |
	
	bf := MJBlameFile new fileName: 'unknown.java'.
	
	john := MJAuthor named: 'John'.
	bl1 := MJBlameFileLine new author: john.
	bl2 := MJBlameFileLine new author: john.
	
	bf addLine: bl1.
	bf addLine: bl2.

	class := FAMIXClass new.
	
	assoc := MJBlameClassAssociation new.
	assoc target: class.
	assoc source: bf.
	
	class addAssociatedBlame: assoc.
	bf addAssociatedClass: assoc.
	
	self assert: class expert equals: john.
]
