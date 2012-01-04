Class {
	#name : #MJCCPSource,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'cloneClass',
		'codeClass',
		'startLine',
		'endLine',
		'pcid',
		'file'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPSource >> cloneClass [
	^ cloneClass
]

{ #category : #accessing }
MJCCPSource >> cloneClass: anObject [
	cloneClass := anObject
]

{ #category : #accessing }
MJCCPSource >> codeClass [
	^ codeClass
]

{ #category : #accessing }
MJCCPSource >> codeClass: anObject [
	codeClass := anObject
]

{ #category : #accessing }
MJCCPSource >> endLine [
	^ endLine
]

{ #category : #accessing }
MJCCPSource >> endLine: anObject [
	endLine := anObject
]

{ #category : #accessing }
MJCCPSource >> file [
	^ file
]

{ #category : #accessing }
MJCCPSource >> file: anObject [
	file := anObject
]

{ #category : #accessing }
MJCCPSource >> pcid [
	^ pcid
]

{ #category : #accessing }
MJCCPSource >> pcid: anObject [
	pcid := anObject
]

{ #category : #accessing }
MJCCPSource >> startLine [
	^ startLine
]

{ #category : #accessing }
MJCCPSource >> startLine: anObject [
	startLine := anObject
]
