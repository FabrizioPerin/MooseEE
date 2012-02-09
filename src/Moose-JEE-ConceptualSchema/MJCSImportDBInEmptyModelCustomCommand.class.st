Class {
	#name : #MJCSImportDBInEmptyModelCustomCommand,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-ConceptualSchema'
}

{ #category : #'as yet unclassified' }
MJCSImportDBInEmptyModelCustomCommand >> execute [
	
	| file mooseModel |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[
			mooseModel := MooseModel new.
			mooseModel name: (file name sliceFrom: ((file name findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1)  to: file name size ).
	
			mooseModel importDBStructureConceptualSchemaCustomFrom: (StandardFileStream readOnlyFileNamed: file name).
			
			mooseModel install].
]

{ #category : #'as yet unclassified' }
MJCSImportDBInEmptyModelCustomCommand >> label [
	^ 'Import DB Conceptual Coupling Custom'
]
