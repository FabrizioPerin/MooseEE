Class {
	#name : #MJBlameClassAssociation,
	#superclass : #MJAssociation,
	#instVars : [
		'blameFile',
		'famixClass'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #'as yet unclassified' }
MJBlameClassAssociation class >> annotation [
	<MSEClass: #MJBlameClassAssociation super: #MJAssociation>
	<package: #'Moose-JEE-GitLog-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> from [
	^self sourceBlameFile
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> initialize [
	super initialize.
	
	blameFile := nil.
	famixClass := nil.
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name asString].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name asString].
	aStream nextPutAll: ' (BlameClass Association)'
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> sourceBlameFile [
	
	<MSEProperty: #sourceBlameFile type: #MJBlameFile opposite: #associatedClass>
	<MSEComment: 'Blame file associated with the class.'>
	
	^blameFile
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> sourceBlameFile: aBlameFile [

	blameFile := FMMultivalueLink
		on: self
		update: #associatedClass
		from: self sourceBlameFile
		to: aBlameFile
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> targetClass [
	
	<MSEProperty: #targetClass type: #FAMIXClass opposite: #associatedBlameFile>
	<MSEComment: 'Class associated with the blame file.'>
	
	^famixClass
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> targetClass: aClass [

	blameFile := FMMultivalueLink
		on: self
		update: #associatedBlameFile
		from: self targetClass
		to: aClass
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> to [
	^self targetClass 
]
