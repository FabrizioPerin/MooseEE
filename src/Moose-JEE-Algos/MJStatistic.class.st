Class {
	#name : #MJStatistic,
	#superclass : #Object,
	#category : #'Moose-JEE-Algos'
}

{ #category : #'as yet unclassified' }
MJStatistic >> average: aCollectionOfNumbers [
	^(aCollectionOfNumbers sum: [:each | each]) / aCollectionOfNumbers size
]

{ #category : #'as yet unclassified' }
MJStatistic >> squareVariance: aCollectionOfNumbers [
	| average |
	
	average := self average: aCollectionOfNumbers.
	
	^ (aCollectionOfNumbers sum: [:each | (each - average) squared]) / aCollectionOfNumbers size.
]
