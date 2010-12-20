Class {
	#name : #MJImportDatabaseIntoEmptyModel,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJImportDatabaseIntoEmptyModel >> execute [
	
	| file mooseModel |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[
			mooseModel := MooseModel new.
			mooseModel name: (file name sliceFrom: ((file name findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1)  to: file name size ).
	
			mooseModel importDBFromSQLFile: (StandardFileStream readOnlyFileNamed: file name)].
		
			MooseModel root add: mooseModel.
			
	self updateModelList.
]

{ #category : #'as yet unclassified' }
MJImportDatabaseIntoEmptyModel >> label [
	^ 'Import Relational Data Base in an empty model'
]
