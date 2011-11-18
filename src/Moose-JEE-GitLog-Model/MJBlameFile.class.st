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
	super initialize.
	lines := OrderedCollection new.
	fileName := nil.
	^self
]

{ #category : #accessing }
MJBlameFile >> lines [
	^ lines
]

{ #category : #accessing }
MJBlameFile >> lines: aCollection [
	lines := aCollection
]

{ #category : #accessing }
MJBlameFile >> printOn: aStream [

	self fileName isNil ifFalse: [aStream nextPutAll: self fileName asString].
	aStream nextPutAll: ' (BlameFile)'.

]
