Class {
	#name : #MJAuthor,
	#superclass : #MooseEntity,
	#instVars : [
		'name'
	],
	#category : #'Moose-JEE-GitLog-Model'
}

{ #category : #'as yet unclassified' }
MJAuthor class >> named: aString [
	^self new name: aString
]

{ #category : #accessing }
MJAuthor >> name [
	^ name
]

{ #category : #accessing }
MJAuthor >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MJAuthor >> printOn: aStream [

	self name isNil ifFalse: [aStream nextPutAll: self name.].
	aStream nextPutAll: ' (Author)'
]
