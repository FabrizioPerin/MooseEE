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
MJGitBlameImporter >> computeTheConnectionsWithClasses [
	| result |
	result := OrderedCollection new.
		
	(self targetModel allClasses reject: [:class | class name startsWithDigit]) do: [ :class | 
			self targetModel allBlameFiles collect: [ :bf | 
					class hasSourceAnchor
						ifTrue: [ (class sourceAnchor fileName endsWith: bf mooseName asString)
									ifTrue: [ 
										| assoc |
										assoc := MJBlameClassAssociation new.
										assoc targetClass: class.
										assoc sourceBlameFile: bf.
										class associatedBlameFile.
										result add: assoc.
										] ] ] ].
	^result
]

{ #category : #accessing }
MJGitBlameImporter >> ensureABlameFile: aBlameFileNode [
	| bf aContainerFolder |
	
	aContainerFolder := FAMIXFolder named: aBlameFileNode fileFolderName filedIn: nil.
	bf := MJBlameFile named: aBlameFileNode fileName filedIn: aContainerFolder.
	aContainerFolder addFile: bf.
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
	
	"the content is not useful nor used for now"
	"bfl content: aBlameFileLineNode content."
	
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
MJGitBlameImporter >> importBlameFilesIn: aFolder [
	| index files aCollectionOfEnsuredNodes |
	
	index := 1.
	files := (aFolder entries select: [ :file | file name endsWith: '.blame' ]) reject: [:each | each fileSize = 0].
	aCollectionOfEnsuredNodes := OrderedCollection new.
	
	UIManager default
		displayProgress: 'Importing information from blame files.'
		at: Sensor cursorPoint
		from: 1
		to: files size
		during: [ :bar | 
			
			bar value: index.
			files 
				do: [ :file | 
					| nodes |
					nodes := gitLogASTParser parse: (StandardFileStream readOnlyFileNamed: file fullName) contents.
					aCollectionOfEnsuredNodes
						add:
							(nodes
								collect: [ :node |
									(node isKindOf: PGLPBlameFile)
										ifTrue: [
											| aReifiedNode fileFullName fileName fileFolder fileFullNameArray |
											fileFullName := (file name removeSuffix: '.blame').
											fileFullNameArray := fileFullName subStrings: #. .
											fileName := (fileFullNameArray at: (fileFullNameArray size - 1)) , '.' , (fileFullNameArray at: fileFullNameArray size).
											fileFolder := (fileFullName removeSuffix: '.' , fileName) replaceAllRegex: '\.' with: FileDirectory pathNameDelimiter asString.
											
											aReifiedNode := self reifyPGLPBlameFile: node with: fileName and: fileFolder.
											aReifiedNode accept: gitLogASTVisitor ] ]) first.
					index := index + 1.
					bar value: index ].
			self populateTargetModelWith: aCollectionOfEnsuredNodes ]
]

{ #category : #accessing }
MJGitBlameImporter >> importBlameFilesInAFolder [
	
	| aFolder files index aCollectionOfEnsuredNodes versions |
	
	aFolder := UITheme builder 
		chooseDirectory: 'Choose the folder containing the blame files.' 
		path: '.'.

	aFolder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.' ]
		ifFalse:[ self importBlameFilesIn: aFolder ]
]

{ #category : #initialization }
MJGitBlameImporter >> initialize [
	super initialize.
	
	gitLogASTVisitor := PetitGitLogVisitor new importer: self.
	gitLogASTParser := PetitGitBlameFileParser new.
	authorsSet := Set new.
	
	^self
]

{ #category : #accessing }
MJGitBlameImporter >> populateTargetModelWith: aCollectionOfEnsuredNodes [

	UIManager default
		displayProgress: 'Populating the model'
		at: Sensor cursorPoint
		from: 1
		to: (aCollectionOfEnsuredNodes size + authorsSet size) 
		during: [ :bar |
			| index |
			index := 1.
			bar value: index.
			
			"adding the files"
			aCollectionOfEnsuredNodes do: [:mjBlameFile |
				self targetModel silentlyAdd: mjBlameFile.		
				index := index + 1.
				bar value: index].
			
			"adding the authors"
			authorsSet do: [:author | 
				self targetModel silentlyAdd: author.
				index := index + 1.
				bar value: index].
			 ].
		
]

{ #category : #accessing }
MJGitBlameImporter >> reifyPGLPBlameFile: node with: aFileName [
	
	^node fileName: aFileName.
]

{ #category : #accessing }
MJGitBlameImporter >> reifyPGLPBlameFile: node with: aFileName and: aFileFolderName [
	
	node fileFolderName: aFileFolderName.
	^self reifyPGLPBlameFile: node with: aFileName
]

{ #category : #accessing }
MJGitBlameImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJGitBlameImporter >> targetModel: anObject [
	targetModel := anObject
]
