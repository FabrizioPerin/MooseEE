Class {
	#name : #MJFAMIXDataBaseTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXDataBaseTests >> testAnnotation [
	self assert: MJFAMIXDataBase annotation == MJFAMIXDataBase.
]
