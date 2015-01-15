Class {
	#name : #FAMIXCobolDataDivision,
	#superclass : #FAMIXCobolDivision,
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolDataDivision >> name [
	<MSEProperty: #name type: #String>
	<MSEComment: 'Basic name of the entity, not full reference.'>
	
	^'data division'
]
