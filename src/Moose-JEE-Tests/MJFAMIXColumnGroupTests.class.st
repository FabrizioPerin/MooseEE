Class {
	#name : #MJFAMIXColumnGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXColumnGroupTests >> testAnnotation [
	self assert: MJFAMIXColumnGroup annotation == MJFAMIXColumnGroup.
]
