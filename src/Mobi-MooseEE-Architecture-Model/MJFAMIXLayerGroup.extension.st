Extension { #name : #MJFAMIXLayerGroup }

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayerGroup >> viewLayersPerApplication [
	<menuItem: 'View Layers Per Application' category: 'Mobi Visualizations'>
	| view rawView normalizer |
	
	"view := MOViewRenderer new."
	rawView := RTView new.
	rawView @ RTDraggable.
	view := RTMondrian initializedView: rawView.
	normalizer := RTMultiLinearColor withCommand: [ :comp | ( comp containerComponents collect: #containerComponent ) asSet ].
	self viewLayersPerApplicationUsing: normalizer  On: view.
	^ view openWithStatusbar title: 'Layers per application'
]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayerGroup >> viewLayersPerApplicationUsing: aNormalizer On: view [
		
	view
		nodes: self 
		forEach: [ :layer | layer viewMobiLayerPerApplicationUsing: aNormalizer on: view].
		
	view edges: self from: #yourself to: #lowerLevel.

	view treeLayout
	"view setEdgesAttachPoint: ROVerticalAttachPoint.
	view layout: ROVerticalLaggeredTree new. "
]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayerGroup >> viewLayersSubsets: aDictionary perApplicationUsing: aNormalizer on: view [
	"aDictionary contains as keys the layers to visualize and as values the collection of elements to visualize per layer"
	view
		nodes: aDictionary keys 
		forEach: [ :layer | layer viewMobiLayerSubset: (aDictionary at: layer) PerApplicationUsing: aNormalizer on: view].
		
	view edges: self from: #yourself to: #lowerLevel.

	view treeLayout
	"view setEdgesAttachPoint: ROVerticalAttachPoint.
	view layout: ROVerticalLaggeredTree new. "
]
