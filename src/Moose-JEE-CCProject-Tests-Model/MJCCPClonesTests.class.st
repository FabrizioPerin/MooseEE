Class {
	#name : #MJCCPClonesTests,
	#superclass : #TestCase,
	#instVars : [
		'clone'
	],
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #accessing }
MJCCPClonesTests >> setUp [

	clone := MJCCPClones new.
]

{ #category : #accessing }
MJCCPClonesTests >> testAddClasses [
	| classes class1 class2 |
	
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes isEmpty.
	
	class1 := MJCCPClass new.
	class2 := MJCCPClass new.
	
	clone addToClasses: class1.
	
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes size equals: 1.
	self assert: clone classes first equals: class1.
	
	clone addToClasses: class2.
	
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes size equals: 2.
	self assert: clone classes first equals: class1.
	self assert: clone classes second equals: class2.
	
]

{ #category : #accessing }
MJCCPClonesTests >> testClasses [
	| classes class1 class2 |
	
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes isEmpty.
	
	class1 := MJCCPClass new.
	class2 := MJCCPClass new.
	
	clone classes: (OrderedCollection with: class1 with: class2).
	
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes size equals: 2.
	self assert: clone classes first equals: class1.
	self assert: clone classes second equals: class2.
	
]

{ #category : #accessing }
MJCCPClonesTests >> testClassinfo [	
	| classinfo |
	
	self assert: clone classinfo equals: nil.
	
	classinfo := MJCCPClassinfo new.
	
	clone classinfo: classinfo.
	
	self assert: (clone classinfo isMemberOf: MJCCPClassinfo).
	self assert: clone classinfo equals: classinfo.
]

{ #category : #accessing }
MJCCPClonesTests >> testMJCCPClonesCresation [
	
	self assert: clone systeminfo equals: nil.
	self assert: clone classinfo equals: nil.
	self assert: (clone classes isMemberOf: OrderedCollection).
	self assert: clone classes isEmpty.
]

{ #category : #accessing }
MJCCPClonesTests >> testSysteminfo [
	| sysinfo |
	
	self assert: clone systeminfo equals: nil.
	
	sysinfo := MJCCPSysteminfo new.
	
	clone systeminfo: sysinfo.
	
	self assert: (clone systeminfo isMemberOf: MJCCPSysteminfo).
	self assert: clone systeminfo equals: sysinfo.
]
