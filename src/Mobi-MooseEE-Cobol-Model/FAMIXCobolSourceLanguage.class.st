Class {
	#name : #FAMIXCobolSourceLanguage,
	#superclass : #FAMIXSourceLanguage,
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolSourceLanguage >> isCobol [
	^true
]

{ #category : #'as yet unclassified' }
FAMIXCobolSourceLanguage >> parser [
	^ self privateState attributeAt: #parser ifAbsentPut: [PPCobolCoreParser new]
]
