Class {
	#name : #MJSuccessfulReport,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJSuccessfulReport >> status [ 
	^ REPConcernSuccessStatus new concern: self
]
