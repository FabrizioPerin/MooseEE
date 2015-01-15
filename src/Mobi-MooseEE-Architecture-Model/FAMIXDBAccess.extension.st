Extension { #name : #FAMIXDBAccess }

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccess >> computeRelevantHierarchy [
	| layers |

	layers := Dictionary new.
	
	self computeRelevantHierarchyAndFill: layers.

	^ layers
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccess >> computeRelevantHierarchyAndFill: aDictionary [
	| initialCobolElements |
	
	initialCobolElements := Set withAll: self accessorEntity withDeepCallingCobolLists.
	initialCobolElements add: self accessedEntity.
	
	initialCobolElements
		do: [ :el | 
			el containerLayer isNil
				ifFalse: [ 
					aDictionary
						at: el containerLayer
						ifPresent: [ :collection | collection add: el ]
						ifAbsent: [ aDictionary at: el containerLayer put: (Set with: el) ] ] ].

	^ aDictionary
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccess >> viewHierarchyPerLayers [
	<menuItem: 'View Hierachy per Layer and Application' category: 'Mobi Visualizations'>
	|  view rawView |
	
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	
	self viewHierarchyPerLayersOn: view.
	
	^ view openWithStatusbar title: 'Layers per application'
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccess >> viewHierarchyPerLayersIn: composite [
	<moosePresentationOrder: 274>
	composite roassalWithoutInertia 
		title: 'Layers per application';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewHierarchyPerLayersOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXDBAccess ]
]

{ #category : #'*mobi-mooseee-architecture-model' }
FAMIXDBAccess >> viewHierarchyPerLayersOn: view [
	<menuItem: 'View Hierachy per Layer and Application' category: 'Mobi Visualizations'>
	| layers normalizer |
	
	layers := self computeRelevantHierarchy.
	
	normalizer := RTMultiLinearColor
		withCommand: [ :comp | (comp containerComponents collect: #containerComponent) asSet ].
	
	(MJFAMIXLayerGroup withAll: layers keys) viewLayersSubsets: layers perApplicationUsing: normalizer on: view.

]
