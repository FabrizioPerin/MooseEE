Class {
	#name : #MJCCPClassNodeTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClassNodeTests >> setUp [
	| factory doc parser |

	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'class' withClass: MJCCPClassNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.
]

{ #category : #'as yet unclassified' }
MJCCPClassNodeTests >> testClassElementCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClassNode]) size equals: 5.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPClassNode]) size equals: 20.
]

{ #category : #'as yet unclassified' }
MJCCPClassNodeTests >> testId [
	| classes |

	classes := root allElements select: [:each | each isMemberOf: MJCCPClassNode].
	
	self assert: classes first id equals: '1'.
	self assert: classes second id equals: '2'.
	self assert: classes third id equals: '3'.
	self assert: (classes at: 4) id equals: '4'.
	self assert: (classes at: 5) id equals: '5'.
]

{ #category : #'as yet unclassified' }
MJCCPClassNodeTests >> testnumberOfFragments [
	| classes |

	classes := root allElements select: [:each | each isMemberOf: MJCCPClassNode].
	
	self assert: classes first numberOfFragments equals: '2'.
	self assert: classes second numberOfFragments equals: '3'.
	self assert: classes third numberOfFragments equals: '2'.
	self assert: (classes at: 4) numberOfFragments equals: '2'.
	self assert: (classes at: 5) numberOfFragments equals: '2'.
]

{ #category : #'as yet unclassified' }
MJCCPClassNodeTests >> testnumberOfLines [
	| classes |

	classes := root allElements select: [:each | each isMemberOf: MJCCPClassNode].
	
	self assert: classes first numberOfLines equals: '166'.
	self assert: classes second numberOfLines equals: '113'.
	self assert: classes third numberOfLines equals: '108'.
	self assert: (classes at: 4) numberOfLines equals: '89'.
	self assert: (classes at: 5) numberOfLines equals: '79'.
]
