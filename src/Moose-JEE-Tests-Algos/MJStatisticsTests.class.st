Class {
	#name : #MJStatisticsTests,
	#superclass : #TestCase,
	#instVars : [
		'sixSidedDie'
	],
	#category : #'Moose-JEE-Tests-Algos'
}

{ #category : #'as yet unclassified' }
MJStatisticsTests >> setUp [ 

	sixSidedDie := {1 . 2 . 3 . 4 . 5 . 6}
]

{ #category : #'as yet unclassified' }
MJStatisticsTests >> testAverage [
	self assert: (MJStatistic new average: {1. 2. 3. 4. 5. 6}) equals: 3.5
]

{ #category : #'as yet unclassified' }
MJStatisticsTests >> testSixSidedDieAverage [
	self assert: (MJStatistic new average: sixSidedDie) equals: 3.5
]

{ #category : #'as yet unclassified' }
MJStatisticsTests >> testSquareVariance [
	| avg variance |

	avg := MJStatistic new average: sixSidedDie.
	
	variance := (sixSidedDie sum: [:each | (each - avg) squared]) / sixSidedDie size.
	
	self assert: (variance asFloat truncateTo: 0.01) equals: 2.91.
]
