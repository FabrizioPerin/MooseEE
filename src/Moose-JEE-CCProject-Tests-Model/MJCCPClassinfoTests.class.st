Class {
	#name : #MJCCPClassinfoTests,
	#superclass : #TestCase,
	#instVars : [
		'classinfo'
	],
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> setUp [

	classinfo := MJCCPClassinfo new.
	
]

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> testMJCCPClassInfoCreation [
	
	self assert: classinfo numberOfClones equals: nil.
	self assert: classinfo numberOfClasses equals: nil.
	self assert: classinfo numberOfPairs equals: nil.
	self assert: classinfo numberOfFragments equals: nil.
]

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> testNumberOfClasses [
	
	self assert: classinfo numberOfClasses equals: nil.
	
	classinfo numberOfClasses: 10.
	
	self assert: classinfo numberOfClasses equals: 10.
	
	
	
]

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> testNumberOfClones [
	
	self assert: classinfo numberOfClones equals: nil.

	classinfo numberOfClones: 100.
	
	self assert: classinfo numberOfClones equals: 100.
]

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> testNumberOfFragments [
	
	self assert: classinfo numberOfFragments equals: nil.
	
	classinfo numberOfFragments: 10.
	
	self assert: classinfo numberOfFragments equals: 10.
]

{ #category : #'as yet unclassified' }
MJCCPClassinfoTests >> testNumberOfPairs [
	
	self assert: classinfo numberOfPairs equals: nil.
	
	classinfo numberOfPairs: 10.
	
	self assert: classinfo numberOfPairs equals: 10.
]
