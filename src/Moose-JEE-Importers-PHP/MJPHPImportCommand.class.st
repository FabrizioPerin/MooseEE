Class {
	#name : #MJPHPImportCommand,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> execute [
	| folder model |
	folder := UITheme builder chooseDirectory: 'Select root folder' path: FileDirectory default pathName.
	folder isNil
		ifTrue: [ DialogWindow new alert: 'No Folder selected!' ]
		ifFalse: [ 
			model := self importPHPSourcesFrom: folder.
			model size > 0
				ifTrue: [ 
					model install.
					self addModel: model ] ]
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> importPHPSourcesFrom: aFolder [
	| importer files result alerts root language model |
	model := MoosePHPModel new.
	alerts := OrderedCollection new.
	files := aFolder fullNamesOfAllFilesInSubtree select: [ :item | (item endsWith: '.php') or: [item endsWith: '.inc'] ]. 
	UIManager default
		displayProgress: 'Importing PHP source code...'
		at: Sensor cursorPoint
		from: 1
		to: files size
		during: [ :bar | 
			| counter |
			counter := 1.
			root := FAMIXFolder named: aFolder fullName filedIn: nil.
			model name: aFolder basename.
			importer := MJPHPImporter new targetModel: model.
			bar
				value: 1;
				value: 'Loading files.'.
			
			files
				do: [ :filename | 
					| file |
					file := filename asFileReference.
					bar value: counter.
					bar value: 'Parsing ' , (self progressBarLabelFor: file) , ' (' , counter asString , '/' , files size asString , ')'.
					result := importer importPHPFile: file.
					result isPetitFailure
						ifTrue: [ self onError: result with: alerts in: file ]
						ifFalse: [ 
							counter := counter + 1.
							root addFile: result ] ].
			bar value: 'Populating the model.'.
			importer populateTargetModelFromRootFolder: root.
			self reportErrors: alerts from: files.
			^ model ].
	^ model
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> label [
	^ 'Import PHP sources from the file system.'
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> onError: aPPFailure with: anErrorCollection in: aFile [
	anErrorCollection add: 'Parsing of ' , aFile fullName , ' failed with message ' , aPPFailure message.
	^ aPPFailure
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> progressBarLabelFor: aFile [
	^ aFile basename
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> reportErrors: aCollectionOfErrorMessages from: aCollectionOfFiles [
	"react on errors at the end of importing"

	aCollectionOfErrorMessages size > 0
		ifTrue: [ 
			DialogWindow new
				alert: aCollectionOfFiles size asString , ' files parsed (' , aCollectionOfErrorMessages size asString , ' failed!)' ]
]
