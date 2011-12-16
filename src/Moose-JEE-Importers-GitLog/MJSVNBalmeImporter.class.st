Class {
	#name : #MJSVNBalmeImporter,
	#superclass : #MJGitBlameImporter,
	#category : #'Moose-JEE-Importers-GitLog'
}

{ #category : #initialization }
MJSVNBalmeImporter >> initialize [
	super initialize.
	
	gitLogASTParser := PetitSVNBlameParser new.
	
	^self
]
