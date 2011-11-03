Class {
	#name : #MJGitBlameImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'gitLogASTVisitor',
		'gitLogASTParser'
	],
	#category : #'Moose-JEE-Importers-GitLog'
}

{ #category : #'initialize-release' }
MJGitBlameImporter class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #accessing }
MJGitBlameImporter >> ensureABlameFileLine: aBlameFileLineNode [
	
	
]

{ #category : #accessing }
MJGitBlameImporter >> gitLogASTParser [
	^ gitLogASTParser
]

{ #category : #accessing }
MJGitBlameImporter >> gitLogASTVisitor [
	^ gitLogASTVisitor
]

{ #category : #initialization }
MJGitBlameImporter >> initialize [
	super initialize.
	
	gitLogASTVisitor := PetitGitLogVisitor new importer: self.
	gitLogASTParser := PetitGitLogParser new.

]

{ #category : #accessing }
MJGitBlameImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJGitBlameImporter >> targetModel: anObject [
	targetModel := anObject
]
