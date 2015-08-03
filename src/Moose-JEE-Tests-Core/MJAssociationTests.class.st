Class {
	#name : #MJAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJAssociationTests >> testAnnotation [
	self assert: MEEAssociation annotation == MEEAssociation.
]
