Class {
	#name : #MJBlameFile,
	#superclass : #MooseEntity,
	#instVars : [
		'fileName',
		'lines'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #accessing }
MJBlameFile >> addLine: aPGLPFileLine [
	lines add: aPGLPFileLine.
]

{ #category : #accessing }
MJBlameFile >> fileName [
	^ fileName
]

{ #category : #accessing }
MJBlameFile >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
MJBlameFile >> initialize [
	lines := OrderedCollection new.
	^self
]

{ #category : #accessing }
MJBlameFile >> lines [
	^ lines
]

{ #category : #accessing }
MJBlameFile >> lines: anObject [
	lines := anObject
]
