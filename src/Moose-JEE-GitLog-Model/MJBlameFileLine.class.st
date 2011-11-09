Class {
	#name : #MJBlameFileLine,
	#superclass : #MooseEntity,
	#instVars : [
		'lineNumber',
		'author',
		'time',
		'content',
		'revision'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #accessing }
MJBlameFileLine >> author [
	^ author
]

{ #category : #accessing }
MJBlameFileLine >> author: aMJAuthor [
	author := aMJAuthor
]

{ #category : #accessing }
MJBlameFileLine >> content [
	^ content
]

{ #category : #accessing }
MJBlameFileLine >> content: anObject [
	content := anObject
]

{ #category : #accessing }
MJBlameFileLine >> number [
	^ lineNumber
]

{ #category : #accessing }
MJBlameFileLine >> number: aNatural [
	lineNumber := aNatural
]

{ #category : #accessing }
MJBlameFileLine >> printOn: aStream [

	self number isNil ifFalse:[aStream nextPutAll: self number asString].
	aStream nextPutAll: ' (BlameFileLine)'
]

{ #category : #accessing }
MJBlameFileLine >> revision [
	^ revision
]

{ #category : #accessing }
MJBlameFileLine >> revision: aRevisionNumber [
	revision := aRevisionNumber
]

{ #category : #accessing }
MJBlameFileLine >> time [
	^ time
]

{ #category : #accessing }
MJBlameFileLine >> time: aDateAndTimeObject [
	time := aDateAndTimeObject
]
