Extension { #name : #MooseModel }

{ #category : #'*moose-jee-jsp-model' }
MooseModel >> allJSPInvocations [
	<navigation: 'All JSPage Invocations'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPInvocation.
	group description: 'JSPage Invocations'.
	^group
]

{ #category : #'*moose-jee-jsp-model' }
MooseModel >> allJSPages [
	<navigation: 'All JSPages'>

	| group |
	
	group :=  self allWithType: MJFAMIXJSPPage.
	group description: 'JSPages'.
	^group
]

{ #category : #'*moose-jee-jsp-model' }
MooseModel >> importJSPagesContainedInto: aFolderPath [
	
	| result fileSystem entries fileEntries counter |

	fileSystem := FSFilesystem onDisk referenceTo: aFolderPath.
	entries := FSCollectVisitor breadthFirst: fileSystem.
	
	fileEntries := entries select: [:entry | '^.*.jsp$' asRegexIgnoringCase matches: entry reference name ].

	counter := 1.			
	UIManager default
		displayProgress: 'Importing From jsp files'
		at: Sensor cursorPoint
		from: 1 
		to: fileEntries size
		during: [ :bar | 
			bar  value: counter.
			
			fileEntries do: [:entry |					
					 | fileStream parser |
					
					PPParserResource reset.
					parser := PPParserResource current parserAt: PetitJSPParser.
					
					fileStream := StandardFileStream readOnlyFileNamed: (entry reference name).
					result := parser parseJSPFrom: fileStream.
					
					self populateWithJSPsFrom:  parser blackboard.

					counter := counter + 1.
					bar value: counter.
				]].
]

{ #category : #'*moose-jee-jsp-model' }
MooseModel >> importJSPagesContainedIntoAFolderGUI [

	<menuItem: 'Import JS Pages from folder' category: 'JEAs Importers'>

	| folderName |
	
	folderName := UIManager default chooseDirectory: 'Folder Name:'.
	folderName = '' ifTrue: [^self].

	self importJSPagesContainedInto: folderName pathName.
]

{ #category : #'*moose-jee-jsp-model' }
MooseModel >> populateWithJSPsFrom: aBlackBoard [

	MJJSPImporter new populate: self withJSPsFrom: aBlackBoard.
	
	^self
]
