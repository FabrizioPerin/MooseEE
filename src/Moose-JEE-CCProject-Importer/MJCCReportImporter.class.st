Class {
	#name : #MJCCReportImporter,
	#superclass : #Object,
	#instVars : [
		'parser',
		'doc',
		'root',
		'targetModel',
		'lastClone'
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

{ #category : #'as yet unclassified' }
MJCCReportImporter >> linkSourcesAndFilesOrClasses [
	| famixClass famixFile sourcesToCheck |
	
	"sourcesToCheck := self targetModel allCloneSources select: [:each | each codeClass isNil and: [each codeFile isNil ] ]."
	sourcesToCheck := lastClone classes collection flatCollect: [:class | class sources].
	
	MooseCustomTask 
		runWithProgress: [
			self targetModel allFiles size = 0
				ifTrue: [ 
					sourcesToCheck
						do: [ :source | 
							famixClass := self targetModel allClasses
								detect: [ :class | (source file removeSuffix: '.java') transformInMoosePathFormat endsWith: class mooseName asString ]
								ifNone: [ nil ].
							famixClass isNil
								ifFalse: [ famixClass addClone: source ] ] ]
				ifFalse: [ 
					sourcesToCheck
						do: [ :source | 
							famixFile := self targetModel allFiles
								detect: [ :file | source file endsWith: (FileDirectory pathNameDelimiter asString , file name asString) ]
								ifNone: [ nil ].
							famixFile isNil
								ifFalse: [ source codeFile: famixFile ] ] ] ]
		description: 'Linking ' , sourcesToCheck size asString , ' Sources'
		length: sourcesToCheck size
	
]

{ #category : #accessing }
MJCCReportImporter >> parser [
	^parser
]

{ #category : #'as yet unclassified' }
MJCCReportImporter >> populateTargetModelWith: aCollectionOfEnsuredNodes [
	| result sources |

	result := (root allElements select: [:eachElement | eachElement class = MJCCPClonesNode]) collect: [:eachElement |
							eachElement createElementFrom: self targetModel].
	
	lastClone := result first.
	
	targetModel silentlyAdd: lastClone systeminfo.
	targetModel silentlyAdd: lastClone classinfo.
	targetModel silentlyAddAll: lastClone classes.
	
	lastClone classes do: [:class | targetModel silentlyAddAll: class sources ].
	
	targetModel add: lastClone.
	
	self linkSourcesAndFilesOrClasses.
	
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
