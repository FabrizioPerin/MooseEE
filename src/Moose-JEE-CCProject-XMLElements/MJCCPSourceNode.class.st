Class {
	#name : #MJCCPSourceNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPSourceNode >> createElementFrom: aMooseModel [
	| source famixClass famixFile |
	
	source := MJCCPSource new.
	
	source endLine: self endLine asNumber.
	source file: self file.
	source pcid: self id asNumber. 
	source startLine: self startLine asNumber.

	 (aMooseModel allFiles size = 0)
		ifTrue: [
			famixClass := aMooseModel allClasses detect: [:class | (self file removeSuffix: '.java') transformInMoosePathFormat endsWith: class mooseName asString ] ifNone: [nil].

			famixClass isNil	
				ifFalse: [famixClass addClone: source].]
		ifFalse: [
			famixFile := aMooseModel allFiles detect: [:file | self file endsWith: ( FileDirectory pathNameDelimiter asString , file name asString )] ifNone: [nil].
			
			famixFile isNil
				ifFalse: [source codeFile: famixFile ] ].
			
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
