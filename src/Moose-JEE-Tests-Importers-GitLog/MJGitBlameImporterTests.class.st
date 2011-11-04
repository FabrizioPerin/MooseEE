Class {
	#name : #MJGitBlameImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'gitImporter',
		'mm'
	],
	#category : #'Moose-JEE-Tests-Importers-GitLog'
}

{ #category : #tests }
MJGitBlameImporterTests >> setUp [

	mm := MooseModel new name: 'TestModel'. 

	gitImporter := MJGitBlameImporter on: mm.
]

{ #category : #tests }
MJGitBlameImporterTests >> testEnsureABlameFile [


	| bfn line1 author1 now1 author now line2 author2 now2 lines aMJBlameFile |
	bfn := PGLPBlameFile new.
	
	line1 :=  MJBlameFileLine new.
	author1 := MJAuthor named: 'john'.
	now1 := DateAndTime now.
	
	line1 author: author.
	line1 revision: 1000.
	line1 time: now.
	line1 number: 10.
	
	line2 := MJBlameFileLine new.
	author2 := MJAuthor named: 'johnDoe'.
	now2 := DateAndTime now.
	
	line2 author: author.
	line2 revision: 1000.
	line2 time: now.
	line2 number: 10.
	
	lines := OrderedCollection with: line1 with: line2.
	
	bfn fileName: 'unknown.java'.
	bfn lines: lines.
	
	aMJBlameFile := gitImporter ensureABlameFile: bfn.
	
	self assert: aMJBlameFile fileName equals: 'unknown.java'.
	self assert: aMJBlameFile lines size equals: 2.
	self assert: (aMJBlameFile lines allSatisfy: [:line | line isMemberOf:  MJBlameFileLine]).
]

{ #category : #tests }
MJGitBlameImporterTests >> testEnsureABlameFileLine [	

	| bfln author now aMJBlameFileLine |
	
	bfln := PGLPBlameFileLine new.
	author := PGLPAuthor new authorName: 'john'.
	now := DateAndTime now.
	
	bfln author: author.
	bfln revision: 1000.
	bfln time: now.
	bfln number: 10.
	
	aMJBlameFileLine := gitImporter ensureABlameFileLine: bfln.
	
	self assert: aMJBlameFileLine author equals: author.
	self assert: aMJBlameFileLine revision equals: 1000.
	self assert: aMJBlameFileLine time equals: now.
	self assert: aMJBlameFileLine number equals: 10.

]

{ #category : #tests }
MJGitBlameImporterTests >> testEnsureAnAuthor [	

	| author aMJAuthor |
	
	author := PGLPAuthor new authorName: 'john'.
	
	aMJAuthor := gitImporter ensureAnAuthor: author.
	
	self assert: aMJAuthor name equals: 'john'.

]

{ #category : #tests }
MJGitBlameImporterTests >> testGitLogASTParser [
	
	self assert: (gitImporter gitLogASTParser isMemberOf: PetitGitLogParser).
]

{ #category : #tests }
MJGitBlameImporterTests >> testGitLogASTVisitor [
	
	self assert: (gitImporter gitLogASTVisitor isMemberOf: PetitGitLogVisitor).
]

{ #category : #tests }
MJGitBlameImporterTests >> testImporterCreation [

	self assert: (gitImporter isMemberOf: MJGitBlameImporter).
	self assert: gitImporter targetModel equals: mm.

]