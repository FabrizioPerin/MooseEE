Class {
	#name : #MobiDataAccessorsLayer,
	#superclass : #MJFAMIXBusinessLayer,
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
MobiDataAccessorsLayer >> acceptStrategy: aLayeringStrategy [
	aLayeringStrategy populateDataAccessorsLayer: self  
	
]

{ #category : #'as yet unclassified' }
MobiDataAccessorsLayer >> isDataAccessorsLayer [
	^true
]

{ #category : #'as yet unclassified' }
MobiDataAccessorsLayer >> name [
	^'Data Accessors'
]
