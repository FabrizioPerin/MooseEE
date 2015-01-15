Extension { #name : #FAMIXDBAccessGroup }

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccessGroup >> viewHierarchyPerLayers [
	<menuItem: 'View Hierachy per Layer and Application' category: 'Mobi Visualizations'>
	| rawView view |
	
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	
	self viewHierarchyPerLayersOn: view.
	
	^ view openWithStatusbar title: 'Layers per application'
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccessGroup >> viewHierarchyPerLayersIn: composite [
	<moosePresentationOrder: 274>
	composite roassalWithoutInertia
		title: 'Layers per application';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithLayersAndColors;
		painting: [ :view :each | each mooseInterestingEntity viewHierarchyPerLayersOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXDBAccessGroup ]
		
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccessGroup >> viewHierarchyPerLayersOn: view [
	| layers normalizer |
	
	layers := Dictionary new.
	self do: [ :each | each computeRelevantHierarchyAndFill: layers ].
 
	normalizer := RTMultiLinearColor
		withCommand: [ :comp | (comp containerComponents collect: #containerComponent) asSet ].
	
	layers keys asMooseGroup viewLayersSubsets: layers perApplicationUsing: normalizer on: view.

]
