Class {
	#name : #MJImportDatabaseUsingASTIntoEmptyModel,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJImportDatabaseUsingASTIntoEmptyModel >> execute [
	
	| file mooseModel |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[
			mooseModel := MooseModel new.
			mooseModel name: (file name sliceFrom: ((file name findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1)  to: file name size ).
	
			mooseModel experimentalImportDBFromSQLFile: (StandardFileStream readOnlyFileNamed: file name).
			
			mooseModel install].
]

{ #category : #'as yet unclassified' }
MJImportDatabaseUsingASTIntoEmptyModel >> label [
	^ 'Import Relational Data Base in an empty model'
]