Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFrom: aFolder [
	
	| parser result ejbVer aFileStream importer files|
	
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
					bar value: 'Parsing ' , counter , '/' ,(files size). 
					importer import: (file readStream contentsOfEntireFile asString).
					counter := counter + 1.
				].
			].
	^self
]

{ #category : #'*moose-jee-importers-php' }
MooseModel >> importPHPSourcesFromSubfolder: aFolder [
	| files |
	files := OrderedCollection new.
	
	aFolder isDirectory ifFalse: [
		^ aFolder.
	].

	aFolder entries do: [ :entry |
			entry isDirectory ifFalse: [
					files addAll: (entry select: [ :fileEntry |
						fileEntry fullName asString endsWith: '.php' 
					]).
				] ifTrue: [
					files addAll: ( self importPHPSourcesFromSubfolder: entry ).
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
		ifFalse:[self importPHPSourcesFrom: folder].
]
