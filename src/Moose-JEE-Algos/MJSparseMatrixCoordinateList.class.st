Class {
	#name : #MJSparseMatrixCoordinateList,
	#superclass : #Object,
	#instVars : [
		'dictionaryOfCoordinates'
	],
	#category : #'Moose-JEE-Algos'
}

{ #category : #accessing }
MJSparseMatrixCoordinateList >> add: aValue atRow: aNumber andColumn: anotherNumber [
	
	^dictionaryOfCoordinates at: {aNumber . anotherNumber} put: aValue.
]

{ #category : #accessing }
MJSparseMatrixCoordinateList >> at: anArrayWithRowAndColumn [
	
	^dictionaryOfCoordinates 
		at: anArrayWithRowAndColumn 
		"ifPresent: [] 
		ifAbsent: []."
]

{ #category : #accessing }
MJSparseMatrixCoordinateList >> coordinates [
	
	^dictionaryOfCoordinates keys
]

{ #category : #accessing }
MJSparseMatrixCoordinateList >> dictionaryOfCoordinates [
	^ dictionaryOfCoordinates
]

{ #category : #accessing }
MJSparseMatrixCoordinateList >> initialize [
	super initialize.
	
	dictionaryOfCoordinates := Dictionary new.
	
	^self 
]
