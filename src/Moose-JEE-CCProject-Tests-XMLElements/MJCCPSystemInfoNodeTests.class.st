Class {
	#name : #MJCCPSystemInfoNodeTests,
	#superclass : #TestCase,
	#instVars : [
		'root'
	],
	#category : #'Moose-JEE-CCProject-Tests-XMLElements'
}

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> setUp [
	| parser factory doc |
	
	parser := XMLDOMParser on: MJCCPSampleReports smallReport readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'systeminfo' withClass: MJCCPSystemInfoNode.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testGranularity [
	| systemInfo |

	systemInfo := root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode].

	self assert: systemInfo size equals: 1.
	self assert: systemInfo first granularity equals: 'blocks'.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testMaxLines [
	| systemInfo |

	systemInfo := root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode].

	self assert: systemInfo size equals: 1.
	self assert: systemInfo first maxLines equals: '500'.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testMinLines [
	| systemInfo |

	systemInfo := root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode].

	self assert: systemInfo size equals: 1.
	self assert: systemInfo first minLines equals: '5'.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testSystem [
	| systemInfo |

	systemInfo := root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode].

	self assert: systemInfo size equals: 1.
	self assert: systemInfo first system equals: 'org'.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testSystemInfoNodeCreation [

	self assert: (root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode]) size equals: 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MJCCPSystemInfoNode]) size equals: 24.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testSystemInfoNodeResolving [
	| sysInfo mm sysinfoElement |
	
	mm := MooseModel new.
	
	sysInfo := (root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode]) first.
	sysinfoElement := sysInfo createElementFrom: mm.
		
	self assert: (sysinfoElement isMemberOf: MJCCPSysteminfo).   	
	self assert: sysinfoElement system equals: 'org'.
	self assert: sysinfoElement granularity equals: 'blocks'.
	self assert: sysinfoElement threshold equals: '30%'.
	self assert: sysinfoElement minLines equals: 5.
	self assert: sysinfoElement maxLines equals: 500.
]

{ #category : #'as yet unclassified' }
MJCCPSystemInfoNodeTests >> testThreshold [
	| systemInfo |

	systemInfo := root allElements select: [:each | each isMemberOf: MJCCPSystemInfoNode].

	self assert: systemInfo size equals: 1.
	self assert: systemInfo first threshold equals: '30%'.
]
