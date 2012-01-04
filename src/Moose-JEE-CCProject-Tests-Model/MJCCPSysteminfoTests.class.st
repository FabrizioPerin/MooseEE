Class {
	#name : #MJCCPSysteminfoTests,
	#superclass : #TestCase,
	#instVars : [
		'sysinfo'
	],
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #accessing }
MJCCPSysteminfoTests >> setUp [

	sysinfo := MJCCPSysteminfo new.
]

{ #category : #accessing }
MJCCPSysteminfoTests >> testMJCCPSysteminfoCreation [	
	
	self assert: (sysinfo isMemberOf: MJCCPSysteminfo).

	self assert: sysinfo system equals: nil.
	self assert: sysinfo granularity equals: nil.
	self assert: sysinfo threshold equals: nil.
	self assert: sysinfo minLines equals: nil.
	self assert: sysinfo maxLines equals: nil.
]

{ #category : #accessing }
MJCCPSysteminfoTests >> testMaxLines [
	
	self assert: sysinfo maxLines equals: nil.	
	
	sysinfo maxLines: 500.

	self assert: sysinfo maxLines equals: 500.
]

{ #category : #accessing }
MJCCPSysteminfoTests >> testMinLines [
	
	self assert: sysinfo minLines equals: nil.
	
	sysinfo minLines: 5.
		
	self assert: sysinfo minLines equals: 5.
	
]

{ #category : #accessing }
MJCCPSysteminfoTests >> testSystem [	
	
	self assert: sysinfo system equals: nil.
	
	sysinfo system: 'org'.
	
	self assert: sysinfo system equals: 'org'.

]

{ #category : #accessing }
MJCCPSysteminfoTests >> testThreshold [
	
	self assert: sysinfo threshold equals: nil.
	
	sysinfo threshold: '30%'.
	
	self assert: sysinfo threshold equals: '30%'.
]
