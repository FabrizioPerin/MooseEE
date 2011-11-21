Class {
	#name : #MJBlameFileTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-GitLog'
}

{ #category : #tests }
MJBlameFileTests >> testAddAssociatedClass [

	| bf blameClassAssoc |
	
	bf := MJBlameFile new.
	
	blameClassAssoc := MJBlameClassAssociation new sourceBlameFile: bf.

	bf addAssociatedClass: blameClassAssoc.
	
	self assert: (bf isMemberOf: MJBlameFile).

	self assert: (bf associatedClass isMemberOf: FMMultivalueLink).
	self assert: (bf associatedClass size = 1).
	self assert: (bf associatedClass first = blameClassAssoc).
	self assert: (bf associatedClass first from = bf).

]

{ #category : #tests }
MJBlameFileTests >> testAddLine [

	| bf oc bl1 bl2 |
	
	bf := MJBlameFile new.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.
	
	bl1 := MJBlameFileLine new.
	bl2 := MJBlameFileLine new.
	bf addLine: bl1.
	bf addLine: bl2.
		
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines size equals: 2.
	self assert: bf lines first equals: bl1.
	self assert: bf lines second equals: bl2.
	
]

{ #category : #tests }
MJBlameFileTests >> testAssociatedClass [

	| bf blameClassAssoc |
	
	bf := MJBlameFile new.
	
	blameClassAssoc := MJBlameClassAssociation new sourceBlameFile: bf.

	bf associatedClass add: blameClassAssoc.
	
	self assert: (bf associatedClass isMemberOf: FMMultivalueLink).
	self assert: (bf associatedClass size = 1).
	self assert: (bf associatedClass first = blameClassAssoc).
	self assert: (bf associatedClass first from = bf).

]

{ #category : #tests }
MJBlameFileTests >> testExpert [

	| bf bl1 bl2 john |
	
	bf := MJBlameFile new.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.

	john := MJAuthor named: 'John'.
	bl1 := MJBlameFileLine new author: john.
	bl2 := MJBlameFileLine new author: john.
	
	bf addLine: bl1.
	bf addLine: bl2.

	self assert: bf expert equals: john. 
]

{ #category : #tests }
MJBlameFileTests >> testExperts [

	| bf bl1 bl2 john |
	
	bf := MJBlameFile new.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.

	john := MJAuthor named: 'John'.
	bl1 := MJBlameFileLine new author: john.
	bl2 := MJBlameFileLine new author: john.
	
	bf addLine: bl1.
	bf addLine: bl2.
	
	self assert: (bf experts isMemberOf: Dictionary).
	self assert: bf experts size equals: 1.
	self assert: (bf experts at: john) equals: 2. 
]

{ #category : #tests }
MJBlameFileTests >> testFileName [

	| bf |
	
	bf := MJBlameFile new.
	
	self assert: bf fileName equals: nil.
	
	bf fileName: 'file1'.
	
	self assert: bf fileName equals: 'file1'.
	
]

{ #category : #tests }
MJBlameFileTests >> testLines [

	| bf oc |
	
	bf := MJBlameFile new.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.
	
	oc := OrderedCollection with: MJBlameFileLine new.
	bf lines: oc.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines size equals: 1.
]

{ #category : #tests }
MJBlameFileTests >> testMJBlameFileCreation [

	| bf |
	
	bf := MJBlameFile new.
	
	self assert: (bf isMemberOf: MJBlameFile).
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.
	self assert: bf fileName isNil.
]

{ #category : #tests }
MJBlameFileTests >> testMooseNameOnWithName [

	| bf aStream |
	
	bf := MJBlameFile new.
	
	bf fileName: 'unknown.java'.
	aStream := ReadWriteStream on: ''.
	bf mooseNameOn: aStream.

	self assert: (aStream contents ) equals: 'unknown.java'.

]

{ #category : #tests }
MJBlameFileTests >> testMooseNameOnWithoutName [

	| bf aStream |
	
	bf := MJBlameFile new.
	
	aStream := ReadWriteStream on: ''.
	bf mooseNameOn: aStream.
	
	self assert: (aStream contents ) equals: 'nil'.

]

{ #category : #tests }
MJBlameFileTests >> testPrintOnWithName [

	| bf aStream |
	
	bf := MJBlameFile new.
	
	self assert: bf fileName isNil.
	
	bf fileName: 'unknown.java'.
	aStream := ReadWriteStream on: ''.
	bf printOn: aStream.

	self assert: (aStream contents ) equals: 'unknown.java (BlameFile)'.

]

{ #category : #tests }
MJBlameFileTests >> testPrintOnWithoutName [

	| bf aStream |
	
	bf := MJBlameFile new.
	
	self assert: bf fileName isNil.
	
	aStream := ReadWriteStream on: ''.
	bf printOn: aStream.
	
	self assert: (aStream contents ) equals: ' (BlameFile)'.

]
