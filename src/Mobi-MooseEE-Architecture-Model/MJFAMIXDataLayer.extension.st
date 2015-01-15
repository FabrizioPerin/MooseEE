Extension { #name : #MJFAMIXDataLayer }

{ #category : #'*mobi-mooseee-architecture-model' }
MJFAMIXDataLayer >> viewMobiLayerSubset: aCollection PerApplicationUsing: aNormalizer on: view [
	| relevantElements |
	
	view interaction 
		dynamicEdgeFromAll: [ :model | (model sourceAccessors reject: #isSelect) collectAsSet: #from]
		using: (ROLine red attachPoint: ROVerticalAttachPoint instance).
	
	view interaction highlightWhenOver: [ :tab | 
		| sourceAccessors |
		sourceAccessors := tab sourceAccessors collectAsSet: #from.
		sourceAccessors := sourceAccessors union: (sourceAccessors flatCollectAsSet: #withDeepCallingCobolLists).
		sourceAccessors ].
	view interaction popupText: [ :el | el asString , String cr , 'Container applications: ' , String cr , (el containerComponents collectAsSet: #from) asString].
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view shape rectangle 
		withText: #name;
		borderWidth: 2;
		borderColor: aNormalizer.
		
	relevantElements := 
		aCollection asSet 
			union: (aCollection 
						flatCollectAsSet: [:each | 
							( each isMemberOf: FAMIXView ) 
								ifTrue: [each ofTables collect: #to ] 
								ifFalse: [ #() ] ] ).
	
	view nodes: (relevantElements asSet sorted: [:a :b | a containerComponents asString < b containerComponents asString]).

	view edges: (self mooseModel allWithType: FAMIXViewAssociation) from: #view to: #table.
	
	view treeLayout
]
