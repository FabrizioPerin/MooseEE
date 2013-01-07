Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFrom: aFolder [
	
	| importer files result alerts root language |
	
	alerts := OrderedCollection new.
	
	UIManager default
		displayProgress: 'Importing PHP source code...'
		at: Sensor cursorPoint
		from: 1 
		to: 3
		during: [ :bar | 
			| counter |
			counter := 1.
			importer := MJPHPImporter new targetModel: self.
			
			bar value: 1.
			bar value: 'Loading files.'.
			
			self sourceLanguage: importer sourceLanguage.
			self add: importer sourceLanguage.
			
			root := FAMIXFolder named: aFolder fullName filedIn: nil.
			
			files := self importPHPSourcesFromSubfolder: aFolder.
			
			bar value: 2.
			
			files do: [:file |
					bar value: 'Parsing ' , (file fullName asString) , ' (' , counter asString , '/' , (files size asString), ')'. 
					result := importer importPHPFile: file.
					(result isMemberOf: PPFailure) ifTrue: [
							alerts add: 'Parsing of ', file fullName, ' failed with message ', result message.
						] ifFalse: [
							counter := counter + 1.
							root addFile: result.
						].
				].
			
			bar value: 3.
			bar value: 'Populating the model.'.
			
			importer populateTargetModelFromRootFolder: root.
			"DialogWindow new alert: counter asString ,' files parsed (', alerts size asString, ' failed!)'."
			].
	^self
]

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFromSubfolder: aDirectoryFile [
	| files folder |
	files := OrderedCollection new.
	
	aDirectoryFile entries do: [ :entry |
			entry isDirectory ifFalse: [
					(entry fullName asString endsWith: '.php') ifTrue: [
							files add: entry.
						].
				] ifTrue: [
					files addAll: ( self importPHPSourcesFromSubfolder: entry asFileDirectory ).
				].
		].
	^ files.
]

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFromUI [
	<menuItem: 'Import php sourcecode from file using AST' category: 'JEAs Importers'>
	
	| folder |
	
	folder := UITheme builder 
		chooseDirectory: 'Select root folder'
		path: FileDirectory default pathName.
		
		
	folder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.'.]
		ifFalse:[ self importPHPSourcesFrom: folder].
]
