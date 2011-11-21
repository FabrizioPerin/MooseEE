Class {
	#name : #MJBlameFileLineTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-GitLog'
}

{ #category : #tests }
MJBlameFileLineTests >> testAuthor [
	| bfl john |
	
	bfl := MJBlameFileLine new.
	
	self assert: bfl author isNil.
	
	john := MJAuthor named: 'John'.
	bfl author: john.
	
	self assert: bfl author equals: john.
]

{ #category : #tests }
MJBlameFileLineTests >> testBlameFileLineCreation [
	| bfl |
	
	bfl := MJBlameFileLine new.
	
	self assert: (bfl isMemberOf: MJBlameFileLine).
]

{ #category : #tests }
MJBlameFileLineTests >> testContent [
	| bfl |
	
	bfl := MJBlameFileLine new.
	
	self assert: bfl content isNil.
	
	bfl content: '/** a generic java doc comment hofully common in the Java files to parse'.
	
	self assert: bfl content equals:  '/** a generic java doc comment hofully common in the Java files to parse'.
]

{ #category : #tests }
MJBlameFileLineTests >> testNumber [
	| bfl |
	
	bfl := MJBlameFileLine new.
	
	self assert: bfl number isNil.

	bfl number: 123.
	
	self assert: bfl number equals: 123.
]

{ #category : #tests }
MJBlameFileLineTests >> testRevision [
	| bfl |
	
	bfl := MJBlameFileLine new.
	
	self assert: bfl revision isNil.

	bfl revision: 123.
	
	self assert: bfl revision equals: 123.
]

{ #category : #tests }
MJBlameFileLineTests >> testTime [
	| bfl dateAndTime |
	
	bfl := MJBlameFileLine new.
	
	self assert: bfl time isNil.
	
	dateAndTime := DateAndTime  now.
	bfl time: dateAndTime.
	
	self assert: bfl time equals: dateAndTime.
]
