Class {
	#name : #MJCCPSource,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'cloneClass',
		'codeClass'
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
