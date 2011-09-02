Class {
	#name : #StringMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #'as yet unclassified' }
StringMJExtensionTests >> testWithoutLineEndings [

	self assert: ('asdf
	asdfdd
	cemjvu' withoutLineEndings =  'asdf	asdfdd	cemjvu' ).
]
