Class {
	#name : #FAMIXCobolIdentificationDivision,
	#superclass : #FAMIXCobolDivision,
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolIdentificationDivision >> name [
	<MSEProperty: #name type: #String>
	<MSEComment: 'Basic name of the entity, not full reference.'>
	
	^'Identification division'
]
