Class {
	#name : #StringMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
StringMJExtensionTests >> testWithoutLineEndings [

	self assert: ('asdf
	asdfdd
	cemjvu' withoutLineEndings =  'asdf	asdfdd	cemjvu' ).
]
