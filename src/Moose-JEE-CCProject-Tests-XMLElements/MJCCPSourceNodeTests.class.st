Class {
	#name : #MJCCPSourceNodeTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> setUp [
	| parser factory doc |

	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'source' withClass: MJCCPSourceNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.
]

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> testEndtLine [

	| sources |

	sources := root allElements select: [:each | each isMemberOf: MJCCPSourceNode].
	
	self assert: sources size equals: 11.
	
	self assert: sources first endLine equals: '892'.
	self assert: sources second endLine equals: '608'.
	self assert: sources third endLine equals: '493'.
	self assert: (sources at: 4) endLine equals: '360'.
	self assert: (sources at: 5) endLine equals: '228'.
	"There are 6 more to check but should be enough with the first 5"
]

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> testFile [

	| sources |

	sources := root allElements select: [:each | each isMemberOf: MJCCPSourceNode].
	
	self assert: sources size equals: 11.
	
	self assert: sources first file equals: '/home/saeed/code/org/compiere/model/MSequence.java'.
	self assert: sources second file equals: '/home/saeed/code/org/compiere/model/MSequence.java'.
	self assert: sources third file equals: '/home/saeed/code/org/compiere/FA/Depreciation.java'.
	self assert: (sources at: 4) file equals: '/home/saeed/code/org/compiere/FA/Depreciation.java'.
	self assert: (sources at: 5) file equals: '/home/saeed/code/org/compiere/FA/Depreciation.java'.
	"There are 6 more to check but should be enough with the first 5"
]

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> testId [
	| sources |

	sources := root allElements select: [:each | each isMemberOf: MJCCPSourceNode].
	
	self assert: sources size equals: 11.
	
	self assert: sources first id equals: '26812'.
	self assert: sources second id equals: '26780'.
	self assert: sources third id equals: '47559'.
	self assert: (sources at: 4) id equals: '47544'.
	self assert: (sources at: 5) id equals: '47527'.
	"There are 6 more to check but should be enough with the first 5"
]

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> testSourceElementCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPSourceNode]) size equals: 11.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPSourceNode]) size equals: 14.
]

{ #category : #'as yet unclassified' }
MJCCPSourceNodeTests >> testStartLine [

	| sources |

	sources := root allElements select: [:each | each isMemberOf: MJCCPSourceNode].
	
	self assert: sources size equals: 11.
	
	self assert: sources first startLine equals: '643'.
	self assert: sources second startLine equals: '372'.
	self assert: sources third startLine equals: '364'.
	self assert: (sources at: 4) startLine equals: '232'.
	self assert: (sources at: 5) startLine equals: '98'.
	"There are 6 more to check but should be enough with the first 5"
]
