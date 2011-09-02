Class {
	#name : #MJAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJAssociationTests >> testAnnotation [
	self assert: MJAssociation annotation == MJAssociation.
]
