Class {
	#name : #MJCCPClassTests,
	#superclass : #TestCase,
	#instVars : [
		'class'
	],
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #accessing }
MJCCPClassTests >> setUp [
	
	class := MJCCPClass new.
	
]

{ #category : #accessing }
MJCCPClassTests >> testId [

	self assert: class id equals: nil.
	
	class id: 5.
	
	self assert: class id equals: 5.
	
	


]

{ #category : #accessing }
MJCCPClassTests >> testMJCCPClassCreation [
	
	self assert: (class isMemberOf: MJCCPClass).
	
	self assert: class id equals: nil.
	self assert: class numberOfLines equals: nil.
	self assert: class numberOfFragments equals: nil.
	self assert: class sources equals: nil.
]

{ #category : #accessing }
MJCCPClassTests >> testNumberOfFragments [
	
	self assert: class numberOfFragments equals: nil.
	
	class numberOfFragments: 12.
	
	self assert: class numberOfFragments equals: 12.
	

]

{ #category : #accessing }
MJCCPClassTests >> testNumberOfLines [

	self assert: class numberOfLines equals: nil.
	
	class numberOfLines: 100.
	
	self assert: class numberOfLines equals: 100.
	
]

{ #category : #accessing }
MJCCPClassTests >> testSources [
	self assert: class sources equals: nil.
	
	class sources: 'TestClass.java'.
	
	self assert: class sources equals: 'TestClass.java'.
	
]
