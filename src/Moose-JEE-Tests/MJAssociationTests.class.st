Class {
	#name : #MJAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJAssociationTests >> testAnnotation [
	self assert: MJAssociation annotation == MJAssociation.
]
