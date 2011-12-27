Class {
	#name : #MJCCPClonesNodeTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> setUp [

	| parser factory doc |
	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'clones' withClass: MJCCPClonesNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClassElements [
	| cloneNode |

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first classElements isMemberOf: XMLOrderedList).
	self assert: (cloneNode first classElements allSatisfy: [:each | each isMemberOf: MJCCPAbstractReportNode]).
	self assert: (cloneNode first classElements allSatisfy: [:each | each name = 'class']).	
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClassElementsNodes [
	| cloneNode parser factory doc |

	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'clones' withClass: MJCCPClonesNode;
				handleElement: 'class' withClass: MJCCPClassNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first classElements isMemberOf: XMLOrderedList).
	self assert: (cloneNode first classElements allSatisfy: [:each | each isMemberOf: MJCCPClassNode]).
	self assert: (cloneNode first classElements allSatisfy: [:each | each name = 'class']).	
	
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClassinfo [
	| cloneNode |

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first classinfo isMemberOf: MJCCPAbstractReportNode).
	self assert: cloneNode first classinfo name equals: 'classinfo'.
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClassinfoNode [
	| cloneNode parser factory doc |

	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'clones' withClass: MJCCPClonesNode;
				handleElement: 'classinfo' withClass: MJCCPClassInfoNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first classinfo isMemberOf: MJCCPClassInfoNode).
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClonesElementCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClonesNode]) size equals: 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPClonesNode]) size equals: 24.
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testClonesElementResolving [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPClonesNode]) size equals: 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPClonesNode]) size equals: 24.
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testSysteminfo [
	| cloneNode |

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first systeminfo isMemberOf: MJCCPAbstractReportNode).
	self assert: cloneNode first systeminfo name equals: 'systeminfo'.
]

{ #category : #'as yet unclassified' }
MJCCPClonesNodeTests >> testSysteminfoNode [
	| cloneNode parser factory doc |

	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'clones' withClass: MJCCPClonesNode;
				handleElement: 'systeminfo' withClass: MJCCPSystemInfoNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	cloneNode := root allElements select: [:each | each isMemberOf: MJCCPClonesNode].

	self assert: cloneNode size equals: 1.
	
	self assert: (cloneNode first systeminfo isMemberOf: MJCCPSystemInfoNode).
	self assert: cloneNode first systeminfo name equals: 'systeminfo'.
]
