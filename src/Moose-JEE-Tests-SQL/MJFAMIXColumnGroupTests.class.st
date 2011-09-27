Class {
	#name : #MJFAMIXColumnGroupTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXColumnGroupTests >> testAnnotation [
	self assert: MJFAMIXColumnGroup annotation == MJFAMIXColumnGroup.
]
