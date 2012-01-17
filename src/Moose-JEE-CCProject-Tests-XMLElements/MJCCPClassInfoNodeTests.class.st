Class {
	#name : #MJCCPClassInfoNodeTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> setUp [
	| parser factory doc |
	
	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'classinfo' withClass: MJCCPClassInfoNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testClassInfoElementCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 24.
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testClassInfoElementResolvingWithDashes [

	| parser factory doc mm classInfo result |
	
	parser := XMLDOMParser on: MJCCPSampleReports smallReportWithDashes readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'classinfo' withClass: MJCCPClassInfoNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	mm := MooseModel new name: 'Test'.

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	
	classInfo := (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first.
	
	result := classInfo createElementFrom: mm.
	
	self assert: (result isMemberOf: MJCCPClassinfo).
	self assert: result numberOfClasses equals: 2.
	self assert: result numberOfClones equals: '----'.
	self assert: result numberOfFragments equals: '----'.
	self assert: result numberOfPairs equals: '-----'.
	
	
	
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testClassInfoElementResolvingWithNumbers [
	| mm classInfo result |

	mm := MooseModel new name: 'test'.

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.

	classInfo := (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first.
	
	result := classInfo createElementFrom: mm.
	
	self assert: (result isMemberOf: MJCCPClassinfo).
	self assert: result numberOfClasses equals: 904.
	self assert: result numberOfClones equals: 7913.
	self assert: result numberOfFragments equals: 8817.
	self assert: result numberOfPairs equals: 7764021.
	
	
	
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testnumberOfClasses [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first numberOfClasses equals: '904'. 
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testnumberOfClones [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first numberOfClones equals: '7913'. 
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testnumberOfFragments [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first numberOfFragments equals: '8817'. 
]

{ #category : #'as yet unclassified' }
MJCCPClassInfoNodeTests >> testnumberOfPairs [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) size equals: 1.
	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassInfoNode]) first numberOfPairs equals: '7764021'.
]
