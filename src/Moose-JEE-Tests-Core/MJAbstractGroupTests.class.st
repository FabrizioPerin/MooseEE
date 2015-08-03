Class {
	#name : #MJAbstractGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJAbstractGroupTests >> testAnnotation [
	self assert: MEEAbstractGroup annotation == MEEAbstractGroup.
]
