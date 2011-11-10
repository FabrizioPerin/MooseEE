Class {
	#name : #MJBlameFilesVersion,
	#superclass : #MJAbstractGroup,
	#instVars : [
		'versionNumber'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #accessing }
MJBlameFilesVersion >> versionNumber [
	^ versionNumber
]

{ #category : #accessing }
MJBlameFilesVersion >> versionNumber: anObject [
	versionNumber := anObject
]
