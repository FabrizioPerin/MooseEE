Class {
	#name : #MJBlameFileTests,
	#superclass : #TestCase,
	#instVars : [
		'fileName',
		'lines'
	],
	#category : #'Moose-JEE-Tests-GitLog'
}

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
]
