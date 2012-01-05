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
	<MSEProperty: #cloneClass type: #MJCCPClass opposite: #sources>
	<MSEComment: 'The clone class representing a chunk of classes containing clones with one another'>
	
	^ cloneClass
]

{ #category : #accessing }
MJCCPSource >> cloneClass: aMJCCPClass [
	cloneClass := FMMultivalueLink 
						on: self
						update: #sources
						from: self cloneClass  
						to: aMJCCPClass
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
MJCCPSource >> initialize [
	super initialize.
	
	cloneClass := nil.
	codeClass := nil.
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
