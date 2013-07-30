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
	model := MooseModel new.
	alerts := OrderedCollection new.
	UIManager default
		displayProgress: 'Importing PHP source code...'
		at: Sensor cursorPoint
		from: 1
		to: 3
		during: [ :bar | 
			| counter |
			counter := 1.
			root := FAMIXFolder named: aFolder fullName filedIn: nil.
			model := MooseModel new name: aFolder basename.
			importer := MJPHPImporter new targetModel: model.
			bar
				value: 1;
				value: 'Loading files.'.
			files := aFolder fullNamesOfAllFilesInSubtree
				select: [ :item | item endsWith: '.php' ].
			bar value: 2.
			files
				do: [ :filename |
					| file |
					file := filename asFileReference. 
					bar value: 'Parsing ' , file fullName asString , ' (' , counter asString , '/' , files size asString , ')'.
					result := importer importPHPFile: file.
					(result isMemberOf: PPFailure)
						ifTrue: [ alerts add: 'Parsing of ' , file fullName , ' failed with message ' , result message ]
						ifFalse: [ 
							counter := counter + 1.
							root addFile: result ] ].
			bar value: 3.
			bar value: 'Populating the model.'.
			importer populateTargetModelFromRootFolder: root.
			alerts size > 0 ifTrue: [
				self halt.
			].
			DialogWindow new alert: counter asString , ' files parsed (' , alerts size asString , ' failed!)'. 
			^ model ].
	^ model
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
MJPHPImportCommand >> label [
	^ 'Import PHP sources from directory system.'
]
