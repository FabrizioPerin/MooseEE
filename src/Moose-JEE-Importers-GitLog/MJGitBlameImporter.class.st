Class {
	#name : #MJGitBlameImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel',
		'gitLogASTVisitor',
		'gitLogASTParser',
		'authorsSet'
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
	| authors |
	
	authors := authorsSet select: [:author | author name = anAuthorNode authorName].
	authors isEmpty 
		ifTrue: [
			| author |
			author := MJAuthor named: anAuthorNode authorName.
			authorsSet add: author.
			^author]
		ifFalse: [
			(authors size > 1) ifTrue: [DialogWindow new alert: 'There is more than one author with the same name.'].
			 ^authors any]
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
	
	| folder files index aCollectionOfEnsuredNodes versions |
	
	folder := UITheme builder 
		chooseDirectory: 'Choose the folder containing the blame files.' 
		path: '.'.

	folder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.' ]
		ifFalse:[
			
			index := 1.			
			files := folder entries select: [:file | file name endsWith: '.blame'].
			aCollectionOfEnsuredNodes := OrderedCollection new.
			
			UIManager default
				displayProgress: 'Importing information from blame files.'
				at: Sensor cursorPoint
				from: 1
				to: files size
				during: [ :bar |
					bar value: index.
					
					"versions := MJBlameFilesVersion new."
					
					files do: [:file |
						| nodes | 
					
						nodes := gitLogASTParser parse: (StandardFileStream readOnlyFileNamed: file fullName) contents.
						aCollectionOfEnsuredNodes add: (nodes collect: [:node | (node isKindOf: PGLPNode) ifTrue: [ node accept: gitLogASTVisitor]]) first.
						"versions addFile: aCollectionOfEnsuredNodes first."
						
						index := index + 1.
						bar value: index].
					
					self populateTheModelWith: aCollectionOfEnsuredNodes.
					
					self halt.]]
]

{ #category : #initialization }
MJGitBlameImporter >> initialize [
	super initialize.
	
	gitLogASTVisitor := PetitGitLogVisitor new importer: self.
	gitLogASTParser := PetitGitLogParser new.
	authorsSet := Set new.
	
	^self
]

{ #category : #accessing }
MJGitBlameImporter >> populateTheModelWith: aCollectionOfEnsuredNodes [

	| index filesSet |
	
	index := 1.

	UIManager default
		displayProgress: 'Populating the model'
		at: Sensor cursorPoint
		from: 1
		to: aCollectionOfEnsuredNodes size
		during: [ :bar |
			bar value: index.
			
		self halt.
			filesSet := Set new.
			
			aCollectionOfEnsuredNodes do: [:mjBlameFile |
				mjBlameFile lines do: [:line | authorsSet add: line author].
			
				index := index + 1.
				bar value: index].
			
			].
]

{ #category : #accessing }
MJGitBlameImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJGitBlameImporter >> targetModel: anObject [
	targetModel := anObject
]
