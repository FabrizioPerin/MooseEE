Class {
	#name : #FAMIXCobolListGroup,
	#superclass : #MooseGroup,
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup class >> annotation [
	<MSEClass: #CobolListGroup super: #MooseGroup>
	<package: #FAMIX>
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> rankIncomingCalls [
	^"("((PageRank new
	referenced: #callingCobolLists;
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) "collect: [ :ea | ea key ]) asMooseGroup"
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> rankOutgoingCalls [
	^"("((PageRank new
	referenced: #calledCobolLists;
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) "collect: [ :ea | ea key ]) asMooseGroup"
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> totalNumberOfCommentedLines [
	<MSEProperty: #totalNumberOfCommentedLines type: #Number>
	<derived>
	<MSEComment: 'Total number of commented lines of code'>

	^self
		lookUpPropertyNamed: #totalNumberOfCommentedLines
		computedAs: [(self sum: [:each | each numberOfCommentedLines]) asFloat]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> totalNumberOfEmptyLines [
	"<MSEProperty: #totalNumberOfEmptyLines type: #Number>
	<derived>
	<MSEComment: 'Total number of empty lines of code'>"

	^self
		lookUpPropertyNamed: #totalNumberOfEmptyLines
		computedAs: [(self sum: [:each | each numberOfEmptyLines ]) asFloat]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> totalNumberOfLinesOfCode [
	<MSEProperty: #totalNumberOfLinesOfCode type: #Number>
	<derived>
	<MSEComment: 'Total number of lines of code'>

	^self
		lookUpPropertyNamed: #totalNumberOfLinesOfCode
		computedAs: [(self sum: [:each | each numberOfLinesOfCode]) asFloat]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccesses [
	<menuItem: 'View Cobol lists database accesses' category: 'Mobi Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewCobolListsDatabaseAccessesOn:  aView.
	aView open.
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccessesConstellation [
	<menuItem: 'View Cobol lists database accesses constellation' category: 'Mobi Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewCobolListsDatabaseAccessesConstellationOn:  aView.
	aView open.
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccessesConstellationIn: composite [
	<moosePresentationOrder: 265>
	composite roassalWithoutInertia
		title: 'Database accesses contellation';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewCobolListsDatabaseAccessesConstellationOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolListGroup ]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccessesConstellationOn: view [
	| model cobolAccessors |
	
	model := self mooseModel.

	view interaction 
		popupView: [ :entity :myView | 
			myView 
				node: #popup
				forIt: [ 
					myView shape label text: #name; width: 80.
					myView node: entity.
					myView shape label text: #name; width: 80.
					myView nodes: entity accessedRelationalEntities asSet.

					myView 
						edges: entity dbAccesses
						from: #from
						to: #to.

					myView treeLayout ] ]
		delay: 2000.

	"view shape rectangle fillColor: Color blue."
	cobolAccessors := ( model allDBAccesses collect: #from ) asSet intersection: self asSet .
	view nodes: cobolAccessors.
	
	view shape rectangle.
	view 
		nodes: ( cobolAccessors flatCollectAsSet: #accessedRelationalEntities )
		forEach: [ :each | 
			view shape label text: #name.
			view node: each ].

	"view shape: (ROOrthoHorizontalLineShape new attachPoint: ROHorizontalAttachPoint instance)."
	view 
		edges: model allDBAccesses
		from: #from
		to: #to.

	view layout: (ROGraphVizReusableLayout new neato reuseOrSaveLayout: 'CobolListsDatabaseAccessesConstellation').
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccessesIn: composite [
	<moosePresentationOrder: 264>
	composite roassalWithoutInertia
		title: 'Database accesses';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewCobolListsDatabaseAccessesOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolListGroup ]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolListsDatabaseAccessesOn: view [
	| model |
	
	model := self mooseModel.
	
	view interaction 
		dynamicEdgeToAll: [ :el | el accessedRelationalEntities asSet ]
		using: (ROOrthoHorizontalLineShape red attachPoint: ROHorizontalAttachPoint instance; width: 3 ).

"	view on: ROMouseLeftClick do: [:event |
		| myView |
		myView := ROMondrianViewBuilder new.
		event element model viewCobolListDatabaseAccessesOn: myView.
		myView open ]."
	view interaction 
		popupView: [ :entity :myView | 
			myView 
				node: #cobol 
				forIt: [ entity viewCobolListDatabaseAccessesOn: myView ] ]
		delay: 2000.
	view shape rectangle withText: #name; width: 80.
	view nodes: ( ( model allDBAccesses collect: #from ) asSet intersection: self asSet ).
	
	view interaction 
		popupView: [ :entity :myView | 
			myView 
				node: #table 
				forIt: [ entity viewDirectAccessorsOn: myView ] ]
		delay: 2000.
	view shape rectangle withText: #name; width: 80.
	view nodes: (self flatCollectAsSet: #accessedRelationalEntities) asMooseGroup.

	view shape: (ROOrthoHorizontalLineShape new attachPoint: ROHorizontalAttachPoint instance).
	view 
		edges: model allDBAccesses
		from: #from
		to: #to.

	view horizontalDominanceTreeLayout layered
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolSystemComplexity [
	<menuItem: 'View Cobol system complexity' category: 'Mobi Visualizations'>
	| view |
	
	view := ROMondrianViewBuilder new.
	self viewCobolSystemComplexityOn:  view.
	view open.
	
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewCobolSystemComplexityOn: view [
	| model |
	
	model := self mooseModel.

	view nodes: self.
	
	view 
		edges: model allCobolCalls
		from: #from
		to: #to.

	view layout: ROGraphVizReusableLayout new dot
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewElements [
	<menuItem: 'View Cobol Elements' category: 'Mobi Visualizations'>
	| view |
	view := ROMondrianViewBuilder new.
	self viewElementsOn: view.
	view open.
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewElementsOn: view [
		
	view shape rectangle
		height: [ :el | el outgoingCalls size + 4 ];
		width: [ :el | el incomingCalls size + 4 ].
		
	view nodes: self.
	
	view gridLayout.
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewIncomingCobolCallsRankNameCloud [
	<menuItem: 'Cobol Incoming Calls Rank Name Cloud' category: 'Visualize'>

	| view rawView |
	
	"view := MOViewRenderer new."
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	self viewIncomingCobolCallsRankNameCloudOn: view.
	^ view openWithStatusbar title: 'Cobol rank by incoming calls'
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewIncomingCobolCallsRankNameCloudIn: composite [ 
	<moosePresentationOrder: 267>
	composite roassalWithoutInertia 
		title: 'Incoming calls rank';
		titleIcon: MooseJEEIcons nameCloud;
		painting: [ :view :each | each mooseInterestingEntity viewIncomingCobolCallsRankNameCloudOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolListGroup ]
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewIncomingCobolCallsRankNameCloudOn: view [ 
	| objects values cobol |
	
	objects := self rankIncomingCalls.
	values := OrderedCollection withAll: (objects collect: #value).
	cobol := OrderedCollection withAll: (objects collect: #key).
	
	view shape label
		text: [:each | each key name];
		linearFontSize: #value within: objects.
		
		
		
"		textColor: (MONColorLinearNormalizer inContext: objects withCommand: [:each | each value size] 
											   lowColor: Color white lowThreshold: 0.1 
											   highColor: Color black highThreshold: 0.9)".
	
	view nodes: objects.
	view bottomFlowLayout maxWidth: 600
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewOutgoingCobolCallsRankNameCloud [
	<menuItem: 'Cobol Outgoing Calls Rank Name Cloud' category: 'Visualize'>

	| rawView view |
	"view := MOViewRenderer new."
	"view := ROMondrianViewBuilder new."
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	self viewOutgoingCobolCallsRankNameCloudOn: view.
	^ view openWithStatusbar title: 'Cobol rank by outgoing calls'
]

{ #category : #'as yet unclassified' }
FAMIXCobolListGroup >> viewOutgoingCobolCallsRankNameCloudOn: view [ 
	| objects |
	
	objects := self rankOutgoingCalls.
	view shape label
		text: [:each | each key name];
		linearFontSize: [:each | each value ] within: objects
"		textColor: (MONColorLinearNormalizer inContext: objects withCommand: [:each | each value size] 
											   lowColor: Color white lowThreshold: 0.1 
											   highColor: Color black highThreshold: 0.9)".
	view nodes: objects.
	view bottomFlowLayout maxWidth: 600
]
