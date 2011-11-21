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

	| bf class assoc |
	
	assoc := MJBlameClassAssociation new.
	class := FAMIXClass new.
	bf := MJBlameFile new.
	
	bf addAssociatedClass: assoc.
	class addAssociatedBlame: assoc.
	
	assoc sourceBlameFile: bf.
	assoc targetClass: class.
	
	self assert: assoc targetClass equals: class.
	self assert: assoc sourceBlameFile equals: bf.
	
	
	
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
	
	class addAssociatedBlame: assoc.
	assoc targetClass: class.

	self assert: assoc targetClass equals: class.
	

]

{ #category : #'as yet unclassified' }
MJBlameClassAssociationTests >> testTo [

	| class assoc |
	
	class := FAMIXClass new.	
	assoc := MJBlameClassAssociation new.
	
	class addAssociatedBlame: assoc.
	assoc targetClass: class.

	self assert: assoc to equals: class.
]
