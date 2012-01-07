Class {
	#name : #StringMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #'as yet unclassified' }
StringMJExtensionTests >> testTransformInMoosePathFormat [

	self assert: '/home/saeed/code/org/compiere/model/MSequence.java' transformInMoosePathFormat equals: 'home::saeed::code::org::compiere::model::MSequence.java'
]

{ #category : #'as yet unclassified' }
StringMJExtensionTests >> testWithoutLineEndings [

	self assert: 'asdf
	asdfdd
	cemjvu' withoutLineEndings equals:  'asdf	asdfdd	cemjvu' .
]
