Extension { #name : #FAMIXDBAccess }

{ #category : #'*mobi-mooseee-cobol-model' }
FAMIXDBAccess >> viewCobolCallHierarchy [
	<menuItem: 'View Cobol Call Hierarchy' category: 'Mobi Visualizations'>
	|  view rawView |
	
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	
	self viewCobolCallHierarchyOn: view.
	
	^ view openWithStatusbar title: 'Cobol Call Hierarchy'
]

{ #category : #'*mobi-mooseee-cobol-model' }
FAMIXDBAccess >> viewCobolCallHierarchyIn: composite [
	<moosePresentationOrder: 275>
	composite roassalWithoutInertia 
		title: 'Cobol Call Hierachy';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColors;
		painting: [ :view :each | each mooseInterestingEntity viewCobolCallHierarchyOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXDBAccess ]
]

{ #category : #'*mobi-mooseee-cobol-model' }
FAMIXDBAccess >> viewCobolCallHierarchyOn: view [
	| allModules |
		
	allModules := Set new.	
	allModules addAll: self from withDeepCallingCobolLists.
	
	view shape label text: #name.
	view node: self to.
	
	view nodes: allModules.
	
	view edges: self mooseModel allDBAccesses from:  #accessorEntity to:  #accessedEntity.
	view edges: self mooseModel allCobolCalls from: #from to: #to.
	
	view dominanceTreeLayout layered. 
]
