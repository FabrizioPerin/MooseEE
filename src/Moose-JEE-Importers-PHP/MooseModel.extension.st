Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFrom: aFolder [
	
	| importer files result|
	
	UIManager default
		displayProgress: 'Importing PHP source code...'
		at: Sensor cursorPoint
		from: 1 
		to: 2
		during: [ :bar | 
			| counter |
			counter := 1.
			importer := MJPHPImporter new targetModel: self.
			
			bar value: 1.
			bar value: 'Loading files.'.
			
			files := self importPHPSourcesFromSubfolder: aFolder.
			
			bar value: 2.
			
			files do: [:file |
					bar value: 'Parsing ' , (file fullName asString) , ' (' , counter asString , '/' , (files size asString), ')'. 
					result := importer importPHPFile: file.
					result isNil ifTrue: [
							^ nil.
						] ifFalse: [
							counter := counter + 1.
						].
				].
			DialogWindow new alert: counter,' files parsed!'.
			].
	^self
]

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFromSubfolder: aDirectoryFile [
	| files |
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
