Class {
	#name : #MJCCPClonesNode,
	#superclass : #MJCCPAbstractReportNode,
	#category : #'Moose-JEE-CCProject-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClonesNode >> classElements [
	^self elements select: [:each | each name = 'class'].
]

{ #category : #'as yet unclassified' }
MJCCPClonesNode >> classinfo [
	^self elements detect: [:each | each name = 'classinfo'] ifNone: [nil]
]

{ #category : #'as yet unclassified' }
MJCCPClonesNode >> createElementFrom: aMooseModel [
	| clones |
	
	clones := MJCCPClones new.
	
	clones systeminfo: (self systeminfo createElementFrom: aMooseModel).
	clones classinfo: (self classinfo createElementFrom: aMooseModel).
	clones classes: (self classElements collect: [:class | class createElementFrom: aMooseModel]).
	
	^clones
]

{ #category : #'as yet unclassified' }
MJCCPClonesNode >> systeminfo [
	^self elements detect: [:each | each name = 'systeminfo'] ifNone: [nil]
]
