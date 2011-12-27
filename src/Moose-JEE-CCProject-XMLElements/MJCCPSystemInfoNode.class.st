Class {
	#name : #MJCCPSystemInfoNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> createElementFrom: aMooseModel [
	| sysinfo |
	
	sysinfo := MJCCPSysteminfo new.
	
	sysinfo granularity: self granularity.
	sysinfo maxLines: self maxLines asNumber.
	sysinfo minLines: self minLines asNumber.
	sysinfo system: self system.
	sysinfo threshold: self threshold.
	
	^sysinfo
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> granularity [
	^self attributes at: 'granularity' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> maxLines [
	^self attributes at: 'maxlines' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> minLines [
	^self attributes at: 'minlines' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> system [
	^self attributes at: 'system' ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNode >> threshold [
	^self attributes at: 'threshold' ifAbsent: [nil].
]
