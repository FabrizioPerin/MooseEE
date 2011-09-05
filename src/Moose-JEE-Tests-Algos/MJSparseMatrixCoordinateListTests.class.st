Class {
	#name : #MJSparseMatrixCoordinateListTests,
	#superclass : #TestCase,
	#instVars : [
		'dictionaryOfCoordinates'
	],
	#category : #'Moose-JEE-Tests-Algos'
}

{ #category : #tests }
MJSparseMatrixCoordinateListTests >> testAddAtRawAndColumn [
	| sparseMatrix |
	
	sparseMatrix := MJSparseMatrixCoordinateList new.
	
	sparseMatrix add: 1 atRow: 1 andColumn: 1.
	sparseMatrix add: 2 atRow: 1 andColumn: 2.
	sparseMatrix add: 3 atRow: 3 andColumn: 2.
	
	self assert: (sparseMatrix dictionaryOfCoordinates keys size = 3).
	
	self assert: (sparseMatrix dictionaryOfCoordinates at: #(1 1)) equals: 1.
	self assert: (sparseMatrix dictionaryOfCoordinates at: #(1 2)) equals: 2.
	self assert: (sparseMatrix dictionaryOfCoordinates at: #(3 2)) equals: 3.
	
	self should: [sparseMatrix dictionaryOfCoordinates at: #(2 1)] raise: KeyNotFound. 

	
]

{ #category : #tests }
MJSparseMatrixCoordinateListTests >> testAt [
	| sparseMatrix |
	
	sparseMatrix := MJSparseMatrixCoordinateList new.
	
	sparseMatrix add: 1 atRow: 1 andColumn: 1.
	sparseMatrix add: 2 atRow: 1 andColumn: 2.
	sparseMatrix add: 3 atRow: 3 andColumn: 2.
	
	self assert: (sparseMatrix dictionaryOfCoordinates keys size = 3).
	
	self assert: (sparseMatrix at: #(1 1)) equals: 1.
	self assert: (sparseMatrix at: #(1 2)) equals: 2.
	self assert: (sparseMatrix at: #(3 2)) equals: 3.
	
	self should: [sparseMatrix at: #(2 1)] raise: KeyNotFound. 

	
]

{ #category : #tests }
MJSparseMatrixCoordinateListTests >> testCoordinates [
	| sparseMatrix |
	
	sparseMatrix := MJSparseMatrixCoordinateList new.
	
	sparseMatrix add: 1 atRow: 1 andColumn: 1.
	sparseMatrix add: 2 atRow: 1 andColumn: 2.
	sparseMatrix add: 3 atRow: 3 andColumn: 2.
	
	self assert: (sparseMatrix coordinates size = 3).
	
	self assert: (sparseMatrix coordinates includes: #(1 1)).
	self assert: (sparseMatrix coordinates includes: #(1 2)).
	self assert: (sparseMatrix coordinates includes: #(3 2)).
]

{ #category : #tests }
MJSparseMatrixCoordinateListTests >> testDictionaryCoordinates [
	| sparseMatrix |
	
	sparseMatrix := MJSparseMatrixCoordinateList new.
	
	self assert: (sparseMatrix dictionaryOfCoordinates isMemberOf: Dictionary).
	 self assert: (sparseMatrix dictionaryOfCoordinates keys isEmpty).
]

{ #category : #tests }
MJSparseMatrixCoordinateListTests >> testMJSparseMatrixCoordinateListCreation [
	| sparseMatrix |
	
	sparseMatrix := MJSparseMatrixCoordinateList new.
	
	self assert: (sparseMatrix isMemberOf: MJSparseMatrixCoordinateList).

]
