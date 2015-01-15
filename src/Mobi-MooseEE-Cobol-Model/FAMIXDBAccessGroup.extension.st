Extension { #name : #FAMIXDBAccessGroup }

{ #category : #'*mobi-mooseee-cobol-model' }
FAMIXDBAccessGroup >> viewCobolCallHierarchy [
	<menuItem: 'View Cobol Call Hierachy' category: 'Mobi Visualizations'>
	| rawView view |
	
	rawView := ROView new.
	rawView @ RODraggable.
	view := ROMondrianViewBuilder initializedView: rawView.
	
	self viewCobolCallHierarchyOn: view.
	
	^ view openWithStatusbar title: 'Cobol Call Hierachy'
]

{ #category : #'*mobi-mooseee-cobol-model' }
FAMIXDBAccessGroup >> viewCobolCallHierarchyOn: view [
	| firstLevelCobolModules allModules |
	
	firstLevelCobolModules := self collectAsSet: #from.
	
	allModules := Set new.	
	allModules addAll: (firstLevelCobolModules flatCollect: #withDeepCallingCobolLists).
	
	view shape label text: #name.
	view nodes: ( self collectAsSet: #to ).
	

	view nodes: allModules.
	
	view edges: self from:  #accessorEntity to:  #accessedEntity.
	view edges: self mooseModel allCobolCalls from: #from to: #to.
	
	view dominanceTreeLayout layered. 
 	
]
