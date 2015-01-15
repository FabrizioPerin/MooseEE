Extension { #name : #MJFAMIXLayer }

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayer >> viewMobiLayer [
	<menuItem: 'View Layer Containing Cobol Elements' category: 'Mobi Visualizations'>
	| view rawView |
	
	"view := MOViewRenderer new."
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	self viewMobiLayerOn: view.
	^ view openWithStatusbar title: 'Layer with cobol elements'
]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayer >> viewMobiLayerOn: view [
	| internalInvocations |
	
	internalInvocations := (self containedElements flatCollect: [ :each | each outgoingCalls ]) asSet select: [:each | each target containerLayer = self ].

	view interaction popupText.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].

	view shape rectangle
		width: [ :el | (el incomingCalls size + 3) min: 25];
		height: [ :el | (el outgoingCalls size + 3) min: 25];
		linearFillColor: [ :el | el numberOfLinesOfCode ] within: self containedElements.
	view nodes: (self containedElements sorted: [:a :b | a containerComponents asString < b containerComponents asString]).
	
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view edges: internalInvocations from: #source to: #target.

	internalInvocations isEmpty
		ifTrue: [ view gridLayout ]
		ifFalse: [ view dominanceTreeLayout layered ]
]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayer >> viewMobiLayerPerApplication [
	<menuItem: 'View Layer Containing Cobol Elements Per Application' category: 'Mobi Visualizations'>
	| view rawView normalizer |
	
	"view := MOViewRenderer new."
	rawView := RTView new.
	rawView @ RTDraggable.
	view := RTMondrian initializedView: rawView.
	normalizer := RTMultiLinearColor withCommand: [ :comp | ( comp containerComponents collect: #containerComponent ) asSet ].
	self viewMobiLayerPerApplicationUsing: normalizer on: view.
	^ view openWithStatusbar title: 'Layer with cobol elements per application'
]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayer >> viewMobiLayerPerApplicationUsing: aNormalizer on: view [

	^self viewMobiLayerSubset: self containedElements PerApplicationUsing: aNormalizer on: view

]

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXLayer >> viewMobiLayerSubset: aCollection PerApplicationUsing: aNormalizer on: view [
	| internalInvocations |

	internalInvocations := (self containedElements flatCollect: [ :each | each outgoingCalls ]) asSet select: [:each | each target containerLayer = self ].
	internalInvocations := internalInvocations asSet union: ((self containedElements flatCollect: [ :each | each incomingCalls ]) asSet select: [:each | each source containerLayer = self ]) asSet.

	"view interaction 
		dynamicEdgeToAll: [ :cob | cob withDeepCalledCobolLists asSet union: cob withDeepCallingCobolLists asSet ]
		using: (ROLine red).	"
	view interaction highlightWhenOver: [ :cob | 
		cob withDeepCalledCobolLists asSet 
			union: (cob withDeepCallingCobolLists asSet 
				union: cob accessedRelationalEntities asSet)].
	view interaction popupText: [ :el | el asString , String cr , 'Container applications: ' , String cr , (el containerComponents collectAsSet: #from) asString].
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].

	view shape rectangle
		width: [ :el | (el incomingCalls size + 3) min: 50];
		height: [ :el | (el outgoingCalls size + 3) min: 50];
		fillColor: aNormalizer.
	view nodes: (aCollection sorted: [:a :b | a containerComponents asString < b containerComponents asString]).
	
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view edges: internalInvocations from: #source to: #target.

	internalInvocations isEmpty
		ifTrue: [ view gridLayout ]
		ifFalse: [ view dominanceTreeLayout ]
]
