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
	assoc targetClass: class.
	assoc sourceBlameFile: bf.
	
	class addAssociatedBlame: assoc.
	bf addAssociatedClass: assoc.
	

	self assert: class expert equals: john.
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testFrom [

	| bf assoc |
	
	bf := MJBlameFile new.	
	assoc := MJBlameClassAssociation new.
	
	assoc sourceBlameFile: bf.
	
	bf addAssociatedClass: assoc.

	self assert: assoc from equals: bf.
	
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testSourceBlameFile [

	| bf assoc |
	
	bf := MJBlameFile new.	
	assoc := MJBlameClassAssociation new.
	
	assoc sourceBlameFile: bf.
	
	bf addAssociatedClass: assoc.

	self assert: assoc sourceBlameFile equals: bf.
	
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testTargetClass [

	| class assoc |
	
	class := FAMIXClass new.	
	assoc := MJBlameClassAssociation new.
	
	assoc targetClass: class.
	
	class addAssociatedBlame: assoc.

	self assert: assoc targetClass equals: class.
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testTo [

	| class assoc |
	
	class := FAMIXClass new.	
	assoc := MJBlameClassAssociation new.
	
	assoc targetClass: class.
	
	class addAssociatedBlame: assoc.

	self assert: assoc to equals: class.
]
