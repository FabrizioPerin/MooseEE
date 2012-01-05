Class {
	#name : #MJCCPSourceNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> createElementFrom: aMooseModel [
	| source |
	
	source := MJCCPSource new.
	
	source endLine: self endLine asNumber.
	source file: self file.
	source pcid: self id asNumber.
	source startLine: self startLine asNumber.
	
	^source
	
]

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> endLine [
	^self attributes at: 'endline' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> file [
	^self attributes at: 'file' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> id [
	^self attributes at: 'pcid' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> startLine [
	^self attributes at: 'startline' ifAbsent: [nil].
]
