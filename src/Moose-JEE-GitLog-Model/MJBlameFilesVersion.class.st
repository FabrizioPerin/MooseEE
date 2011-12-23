Class {
	#name : #MJBlameFilesVersion,
	#superclass : #MJAbstractGroup,
	#instVars : [
		'versionNumber'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #'as yet unclassified' }
MJBlameFilesVersion class >> annotation [
	<MSEClass: #MJBlameFilesVersion super: #MJAbstractGroup>
	<package: #'Moose-JEE-GitLog-Model'>
	^self
]

{ #category : #accessing }
MJBlameFilesVersion >> versionNumber [
	^ versionNumber
]

{ #category : #accessing }
MJBlameFilesVersion >> versionNumber: anObject [
	versionNumber := anObject
]
