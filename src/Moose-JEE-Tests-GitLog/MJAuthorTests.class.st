Class {
	#name : #MJAuthorTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-GitLog'
}

{ #category : #'as yet unclassified' }
MJAuthorTests >> testAuthorCreation [
	| author |
	
	author := MJAuthor new.
	
	self assert: (author isMemberOf: MJAuthor).
	self assert: author name equals: nil.
	
]

{ #category : #'as yet unclassified' }
MJAuthorTests >> testAuthorCreationNamed [
	| author |
	
	author := MJAuthor named: 'Ralph'.
	
	self assert: (author isMemberOf: MJAuthor).
	self assert: author name equals: 'Ralph'.
	
]
