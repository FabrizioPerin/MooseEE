Class {
	#name : #MJFAMIXPHPNamespace,
	#superclass : #FAMIXNamespace,
	#instVars : [
		'separator'
	],
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPNamespace class >> annotation [
	<MSEClass: #MJFAMIXPHPNamespace super: #FAMIXNamespace>
	<package: #'Moose-JEE-PHP-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPNamespace >> initialize [
	super initialize.
	separator := $\.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPNamespace >> mooseNameOn: aStream [
	| parent |
	parent := self belongsTo.
	parent
		ifNotNil: [ 
			parent mooseNameOn: aStream.
			aStream nextPut: self separator ].
	self name ifNotNil: [ aStream nextPutAll: self name ]
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPNamespace >> printOn: aStream [
	self mooseNameOn: aStream.
	aStream nextPutAll: ' (Namespace)'
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPNamespace >> separator [
	^ separator
]
