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
