Class {
	#name : #MJFAMIXMappingGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXMappingGroupTests >> testAnnotation [
	self assert: MJFAMIXMappingGroup annotation == MJFAMIXMappingGroup.
]
