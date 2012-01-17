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
MJCCPSourceTests >> testCloneClass [
	| cc |
	
	self assert: source cloneClass equals: nil.
	
	cc := MJCCPClass new.
	
	source cloneClass: cc.
	
	self assert: source cloneClass equals: cc.
]

{ #category : #accessing }
MJCCPSourceTests >> testCodeClass [
	| famixclass |
	
	self assert: source cloneClass equals: nil.
		
	famixclass := FAMIXClass new name: 'MSequence'.
	famixclass addClone: source.	
	
	self assert: source codeClass equals: famixclass.
	

]

{ #category : #accessing }
MJCCPSourceTests >> testCodeFile [
	| famixFile |
	
	self assert: source codeFile equals: nil.
		
	famixFile := FAMIXFile new name: 'MSequence'.
	famixFile addCloneSource: source.	
	
	self assert: source codeFile equals: famixFile.
	

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
	self assert: source cloneClass equals: nil.
	self assert: source codeClass equals: nil.
	
	
]

{ #category : #accessing }
MJCCPSourceTests >> testStartLine [

	self assert: source startLine equals: nil.

	source startLine: 643.
	
	self assert: source startLine equals: 643.	
]
