Class {
	#name : #MJFAMIXPHPClass,
	#superclass : #FAMIXClass,
	#instVars : [
		'instances',
		'fullName'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPClass class >> annotation [
	<MSEClass: #Class super: #FAMIXClass>
	<package: #PHP>
	^self
]

{ #category : #accessing }
MJFAMIXPHPClass >> fullName [
	^ fullName
]

{ #category : #accessing }
MJFAMIXPHPClass >> fullName: anObject [
	fullName := anObject
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPClass >> isAnnotation [
	^ false
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPClass >> mooseDescription [
	^ super mooseDescription
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPClass >> mooseNameOn: aStream [
	| parent |
	parent := self container.
	parent
		ifNotNil: [ 
			parent mooseNameOn: aStream.
			aStream nextPut: $\ ].
	self name ifNotNil: [ aStream nextPutAll: self name ]
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPClass >> printOn: aStream [
	self mooseNameOn: aStream.
	aStream nextPutAll: ' (Class)'
]
