Class {
	#name : #MJBlameClassAssociation,
	#superclass : #MJAssociation,
	#instVars : [
		'blameFile',
		'sourceEntity'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> from [
	^self source
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> initialize [
	super initialize.
	
	blameFile := nil.
	sourceEntity := nil.
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
MJBlameClassAssociation >> source [
	
	<MSEProperty: #source type: #MJBlameFile opposite: #associatedClass>
	<MSEComment: 'Blame file associated with the class.'>
	
	^blameFile
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> source: aBlameFile [

	blameFile := FMMultivalueLink
		on: self
		update: #associatedClass
		from: self source
		to: aBlameFile
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> target [
	
	<MSEProperty: #target type: #FAMIXClass opposite: #associatedBlameFile>
	<MSEComment: 'Class associated with the blame file.'>
	
	^sourceEntity
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> target: aSourceEntity [

	blameFile := FMMultivalueLink
		on: self
		update: #associatedBlameFile
		from: self target
		to: aSourceEntity
]

{ #category : #'as yet unclassified' }
MJBlameClassAssociation >> to [
	^self target
]
