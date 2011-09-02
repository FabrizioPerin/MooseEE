Class {
	#name : #MJAbstractGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJAbstractGroupTests >> testAnnotation [
	self assert: MJAbstractGroup annotation == MJAbstractGroup.
]
