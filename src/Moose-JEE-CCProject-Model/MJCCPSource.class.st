Class {
	#name : #MJCCPSource,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'cloneClass',
		'codeClass',
		'startLine',
		'endLine',
		'pcid',
		'file',
		'codeFile'
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
	<MSEProperty: #codeClass type: #FAMIXClass opposite: #clones>
	<MSEComment: 'The famix class where the clone has been detected'>
	^ codeClass
]

{ #category : #accessing }
MJCCPSource >> codeClass: anObject [
	codeClass := FMMultivalueLink 
						on: self
						update: #clones
						from: self codeClass  
						to: anObject
]

{ #category : #accessing }
MJCCPSource >> codeFile [
	<MSEProperty: #codeFile type: #FAMIXFile opposite: #cloneSources>
	<MSEComment: 'The famix file where the clone has been detected'>
	^ codeFile
]

{ #category : #accessing }
MJCCPSource >> codeFile: anObject [
	codeFile := FMMultivalueLink 
						on: self
						update: #cloneSources
						from: self codeFile  
						to: anObject
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
MJCCPSource >> from [
	^self cloneClass
]

{ #category : #accessing }
MJCCPSource >> initialize [
	super initialize.
	
	cloneClass := nil.
	codeClass := nil.
	codeFile := nil.
]

{ #category : #accessing }
MJCCPSource >> mooseDisplayStringOn: aStream [

	self cloneClass isNil
		ifFalse: [
			self cloneClass mooseDisplayStringOn: aStream].
		
	aStream nextPutAll: ' -> '.
	
	self codeClass isNil
		ifFalse: [
			self codeClass mooseDisplayStringOn: aStream].
	
	self codeFile isNil
		ifFalse: [
			self codeFile mooseDisplayStringOn: aStream]
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
MJCCPSource >> sourceAnchor [ 

	^nil
]

{ #category : #accessing }
MJCCPSource >> startLine [
	^ startLine
]

{ #category : #accessing }
MJCCPSource >> startLine: anObject [
	startLine := anObject
]

{ #category : #accessing }
MJCCPSource >> to [
	
	self codeClass isNil
		ifFalse: [ ^self codeClass ].
	
	self codeFile isNil
		ifFalse: [ ^self codeFile ].
]
