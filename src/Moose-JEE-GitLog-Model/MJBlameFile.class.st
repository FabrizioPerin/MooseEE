Class {
	#name : #MJBlameFile,
	#superclass : #FAMIXFile,
	#instVars : [
		'fileName',
		'lines',
		'associatedClass'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #accessing }
MJBlameFile >> addAssociatedClass: aMJBlameClassAssociation [
	^self associatedClass add: aMJBlameClassAssociation 
]

{ #category : #accessing }
MJBlameFile >> addLine: aPGLPFileLine [
	lines add: aPGLPFileLine.
]

{ #category : #accessing }
MJBlameFile >> associatedClass [
	<MSEProperty: #associatedClass type: #MJBlameClassAssociation opposite: #sourceBlameFile> <multivalued> <derived>
	<MSEComment: 'Association with the source entity described by this blame file.'>
	
	^associatedClass
]

{ #category : #accessing }
MJBlameFile >> expert [
	| experts max |
	
	experts := self experts.
	max := (experts values sorted: [ :a :b | a > b ]) first.
	experts := experts select: [ :value | max = value ].
	
	^experts keys first
]

{ #category : #accessing }
MJBlameFile >> experts [
	| allOwners |
	allOwners := Dictionary new.
	self lines
		do: [ :line | 
			allOwners
				at: line author
				ifPresent: [ :value | allOwners at: line author put: value + 1 ]
				ifAbsent: [ allOwners at: line author put: 1 ] ].	
	
	^allOwners
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
	associatedClass := FMMultivalueLink on: self opposite: #sourceBlameFile:.
	
	^ self
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
MJBlameFile >> mooseNameOn: aStream [ 
	
	aStream nextPutAll: self fileName asString
]

{ #category : #accessing }
MJBlameFile >> printOn: aStream [

	self fileName isNil ifFalse: [aStream nextPutAll: self fileName asString].
	aStream nextPutAll: ' (BlameFile)'.

]
