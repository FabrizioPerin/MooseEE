Class {
	#name : #MJSuccessfulReport,
	#superclass : #REPComputedConcern,
	#category : #'Moose-JEE-Reports'
}

{ #category : #'as yet unclassified' }
MJSuccessfulReport >> computeResult [
  ^ OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MJSuccessfulReport >> label [ 
  ^ 'Successful report'
]

{ #category : #'as yet unclassified' }
MJSuccessfulReport >> status [ 
	^ REPConcernSuccessStatus new concern: self
]
