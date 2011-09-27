Class {
	#name : #MJDominanceTreeWithGroupsLayout,
	#superclass : #MOAbstractVerticalTreeLayout,
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJDominanceTreeWithGroupsLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]

{ #category : #'as yet unclassified' }
MJDominanceTreeWithGroupsLayout >> doExecute: aGraph [
	| rootNodes notnilGroup nilGroup verify ABB BBA|
	alreadyLayoutedNodes := OrderedCollection new.
	rootNodes := self rootNodesFor: aGraph nodes.
	nodesByLayer := OrderedCollection new.
	
	self
		layout: rootNodes
		atPoint: self leftGap @ self topGap
		atLayer: 1
		grouping: true.
		
	self rearrangeByLayers: aGraph.
	

	" OLD CODE
	notnilGroup := OrderedCollection new.
	nilGroup := OrderedCollection new.
	rootNodes do: [:each | (each model groupNumber = nil)
									ifFalse:[notnilGroup add: each]
									ifTrue:[nilGroup add:each]].
	
	rootNodes := notnilGroup sortBy:[:a :b | a model groupNumber > b model groupNumber].
	rootNodes addAll: nilGroup."
	
	"verify := notnilGroup sortBy:[:a :b | a model groupNumber > b model groupNumber].
	verify addAll: nilGroup.
	
	ABB := rootNodes difference: verify. 
	BBA := verify difference: rootNodes. 
		
	self halt."
]

{ #category : #'as yet unclassified' }
MJDominanceTreeWithGroupsLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber grouping: aBoolean [
	| treeWidth childrenY x y xInMiddleOfTree nodeCollectionToUse|
	aNodeCollection isEmpty
		ifTrue: [ ^ 0 ].

	aBoolean 
		ifTrue:[
				| notnilGroup nilGroup |
				notnilGroup := OrderedCollection new.
				nilGroup := OrderedCollection new.
				aNodeCollection do: [:each | (each model groupNumber = nil)
									ifFalse:[notnilGroup add: each]
									ifTrue:[nilGroup add:each]].
				nodeCollectionToUse := notnilGroup sort:[:a :b | a model groupNumber > b model groupNumber].
				nodeCollectionToUse addAll: nilGroup.]
		ifFalse:[ nodeCollectionToUse := OrderedCollection withAll: aNodeCollection ].

	x := aPoint x.
	y := aPoint y.
	nodeCollectionToUse
		do:
			[ :each | 
			childrenY := y + each height + self verticalGap.
			treeWidth := each width
				max:
					(self
						layout: (self childrenWithHighestNestingLevelFor: each)
						atPoint: x @ childrenY
						atLayer: aNumber + 1
						grouping: true).
			xInMiddleOfTree := x + (treeWidth / 2.0) - (each width / 2.0).
			each translateTo: xInMiddleOfTree @ y.
			x := x + treeWidth + self horizontalGap ].
	^ x - aPoint x - self horizontalGap
]
