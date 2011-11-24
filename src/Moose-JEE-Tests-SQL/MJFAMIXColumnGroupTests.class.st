Class {
	#name : #MJFAMIXColumnGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXColumnGroupTests >> testAnnotation [
	self assert: MJFAMIXColumnGroup annotation == MJFAMIXColumnGroup.
]
