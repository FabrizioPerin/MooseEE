Class {
	#name : #MJCCPSourceTests,
	#superclass : #TestCase,
	#instVars : [
		'source'
	],
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #accessing }
MJCCPSourceTests >> setUp [

	source := MJCCPSource new.
	
]

{ #category : #accessing }
MJCCPSourceTests >> testEndLine [

	self assert: source endLine equals: nil.
	
	source endLine: 892.
	
	self assert: source endLine equals: 892.

]

{ #category : #accessing }
MJCCPSourceTests >> testFile [
	
	self assert: source file equals: nil.
	
	source file: '/home/saeed/code/org/compiere/FA/CreateInvoicedAsset.java'.
	
	self assert: source file equals: '/home/saeed/code/org/compiere/FA/CreateInvoicedAsset.java'.
	
]

{ #category : #accessing }
MJCCPSourceTests >> testId [

	self assert: source pcid equals: nil.
	
	source pcid: 26812.
	
	self assert: source pcid equals: 26812.
	
]

{ #category : #accessing }
MJCCPSourceTests >> testMJCCPSourceCreation [

	self assert: (source isMemberOf: MJCCPSource).
	
	self assert: source endLine equals: nil.
	self assert: source file equals: nil.
	self assert: source pcid equals: nil.
	self assert: source startLine equals: nil.
	
]

{ #category : #accessing }
MJCCPSourceTests >> testStartLine [

	self assert: source startLine equals: nil.

	source startLine: 643.
	
	self assert: source startLine equals: 643.	
]
