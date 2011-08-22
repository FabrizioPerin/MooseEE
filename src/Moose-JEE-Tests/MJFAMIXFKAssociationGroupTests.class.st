Class {
	#name : #MJFAMIXFKAssociationGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXFKAssociationGroupTests >> testAnnotation [
	self assert: MJFAMIXFKAssociationGroup annotation == MJFAMIXFKAssociationGroup.
]
