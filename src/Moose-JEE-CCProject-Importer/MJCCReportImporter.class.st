Class {
	#name : #MJCCReportImporter,
	#superclass : #Object,
	#instVars : [
		'parser',
		'doc',
		'root',
		'targetModel'
	],
	#category : #'Moose-JEE-CCProject-Importer'
}

{ #category : #'as yet unclassified' }
MJCCReportImporter class >> on: aMooseModel [

	^self new targetModel: aMooseModel.
]

{ #category : #'as yet unclassified' }
MJCCReportImporter >> importFrom: aStream [ 
	
	parser input: aStream.
	doc := parser parseDocument.
	root := doc root.
	
	self populateTargetModelWith: root.
	
	 ^ self targetModel
]

{ #category : #initialization }
MJCCReportImporter >> initialize [
	| factory |
	
	parser := XMLDOMParser new. 
	
	factory := XMLPluggableElementFactory new
				elementClass: MJCCPAbstractReportNode;
				handleElement: 'classinfo' withClass: MJCCPClassInfoNode;
				handleElement: 'class' withClass: MJCCPClassNode;
				handleElement: 'clones' withClass: MJCCPClonesNode;
				handleElement: 'systeminfo' withClass: MJCCPSystemInfoNode;
				handleElement: 'source' withClass: MJCCPSourceNode.
	
	parser nodeFactory: factory. 

]

{ #category : #accessing }
MJCCReportImporter >> parser [
	^parser
]

{ #category : #'as yet unclassified' }
MJCCReportImporter >> populateTargetModelWith: aCollectionOfEnsuredNodes [
	| result clones sources |

	result := (root allElements select: [:eachElement | eachElement class = MJCCPClonesNode]) collect: [:eachElement |
							eachElement createElementFrom: self targetModel].
	
	clones := result first.
	
	targetModel silentlyAdd: clones systeminfo.
	targetModel silentlyAdd: clones classinfo.
	targetModel silentlyAddAll: clones classes.
	
	clones classes do: [:class | targetModel silentlyAddAll: class sources ].
	
	targetModel add: clones.
	
	^targetModel
]

{ #category : #accessing }
MJCCReportImporter >> targetModel [
	^targetModel
]

{ #category : #accessing }
MJCCReportImporter >> targetModel: aMooseModel [
	targetModel := aMooseModel.
]
