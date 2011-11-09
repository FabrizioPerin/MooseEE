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
MJGitBlameImporter >> ensureABlameFile: aBlameFileNode [
	| bf |
	
	bf := MJBlameFile new.
	
	bf fileName: aBlameFileNode fileName.
	bf lines: (aBlameFileNode lines collect: [:line | line accept: gitLogASTVisitor]).
	
	^bf
]

{ #category : #accessing }
MJGitBlameImporter >> ensureABlameFileLine: aBlameFileLineNode [
	| bfl |
	
	bfl := MJBlameFileLine new.
	
	bfl author: (aBlameFileLineNode author accept: gitLogASTVisitor).
	bfl revision: aBlameFileLineNode revision.
	bfl time: aBlameFileLineNode time.
	bfl number: aBlameFileLineNode number.
	
	^bfl
]

{ #category : #accessing }
MJGitBlameImporter >> ensureAnAuthor: anAuthorNode [
	| author |
	
	author := MJAuthor named: anAuthorNode authorName.
	
	^author
]

{ #category : #accessing }
MJGitBlameImporter >> gitLogASTParser [
	^ gitLogASTParser
]

{ #category : #accessing }
MJGitBlameImporter >> gitLogASTVisitor [
	^ gitLogASTVisitor
]

{ #category : #accessing }
MJGitBlameImporter >> importBlameFileFrom: aStream [
		
	| blameFileNodes |
	
	blameFileNodes := (gitLogASTParser parse: aStream) deepFlatten.
	
	self populateTargetModelFrom: (blameFileNodes collect: [:node | (node isKindOf: PGLPNode) ifTrue: [ node accept: gitLogASTVisitor]]).
	
	^self targetModel.
]

{ #category : #accessing }
MJGitBlameImporter >> importBlameFilesInAFolder [
	
	| folder files |
	
	folder := UITheme builder 
		chooseDirectory: 'Choose the folder containing the blame files.' 
		path: '.'.

	files := folder entries select: [:file | file name endsWith: '.blame'].

	folder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.' ]
		ifFalse:[
			
			
			UIManager default
				displayProgress: 'Importing information from blame files.'
				at: Sensor cursorPoint
				from: 1
				to: files size
				during: [ :bar |
					files := folder entries select: [:file | file name endsWith: '.blame']. 
					files do: [:file |
						| nodes aCollectionOfEnsuredNodes | 

						nodes := gitLogASTParser parse: (StandardFileStream readOnlyFileNamed: file fullName) contents.
						aCollectionOfEnsuredNodes := (nodes collect: [:node | (node isKindOf: PGLPNode) ifTrue: [ node accept: gitLogASTVisitor]]).		 
						].
					
					
					self halt.]]
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
