Class {
	#name : #MJPHPImportDebugCommand,
	#superclass : #MJPHPImportCommand,
	#category : #'Moose-JEE-Importers-PHP'
}

{ #category : #'as yet unclassified' }
MJPHPImportDebugCommand >> label [
	^ 'Import PHP sources from the file system and debug on error'
]

{ #category : #'as yet unclassified' }
MJPHPImportDebugCommand >> reportErrors: aCollectionOfErrorMessages from: aCollectionOfFiles [
	"react on errors at the end of importing"

	aCollectionOfErrorMessages size > 0
		ifTrue: [ self halt ]
]
