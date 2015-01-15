Extension { #name : #MooseModel }

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> allCobolCalls [
	<navigation: 'All Cobol Calls'>
	| group |
	
	group := self allWithType: FAMIXCobolCall ofGroupClass: FAMIXCobolCallGroup.
	group description: 'All Cobol Calls'.
	
	^group
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> allCobolLists [
	<navigation: 'All Cobol Lists'>
	| group |
	
	group := self allWithType: FAMIXCobolList ofGroupClass: FAMIXCobolListGroup.
	group description: 'All Cobol Lists'.
	
	^group
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> deleteAllCalls [
	<menuItem: 'Delete All Calls' category: 'Mobi Importers'>
	self allCobolCalls do: [ :each | each source: nil. each target: nil. ].
	self silentlyRemoveAll: self allCobolCalls.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> initialize: capacity [
	self initialize.
	storage := MooseGroupRuntimeStorage new: capacity.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel class >> new: capacity [
	^self basicNew initialize: capacity
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewAllCallsTwopi [
	| view |
	
	view := ROMondrianViewBuilder new.
	self viewAllCallsTwopiOn: view.
	view open.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewAllCallsTwopiOn: view [

	view nodes: self allCobolLists.
	view edges: self allCobolCalls from: #from to: #to.
	view layout: (ROGraphVizReusableLayout new twopi reuseOrSaveLayout: 'twopi_justDB_Accessors_calls')
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewDBAccessesHierachy [
	<menuItem: 'DB Accesses Hierarchy' category: 'JEAs Visualizations'>
	| view |
	
	view := ROMondrianViewBuilder new.
	self viewDBAccessesHierachyOn: view.
	view open.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewDBAccessesHierachyOn: view [
	| accesses tablesAndViews cobolLists |
	
	accesses := self allDBAccesses asSet.
	tablesAndViews := (accesses collect: #accessedEntity) asSet asMooseGroup.
	cobolLists := (accesses collect: #accessorEntity) asSet asMooseGroup.
	cobolLists := (cobolLists flatCollect: [ :each | each withDeepCallingCobolLists ]) asSet asMooseGroup.
	
	view nodes: cobolLists.
	view shape rectangle text: #name.
	view nodes: tablesAndViews.
	
	view edges: accesses from: #accessorEntity to: #accessedEntity.
	view edges: self allCobolCalls asSet asMooseGroup from: #source to: #target.
	
	view layout: ROGraphVizReusableLayout new neato.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewInteractiveDBAccessesAndMappingsConstellation [
	<menuItem: 'Interactive DB Accesses and Mappings contellation' category: 'Mobi Visualizations'>
	| view |
	
	view := ROMondrianViewBuilder new.
	self viewInteractiveDBAccessesAndMappingsConstellationOn: view.
	view open.
]

{ #category : #'*mobi-mooseee-cobol-model' }
MooseModel >> viewInteractiveDBAccessesAndMappingsConstellationOn: view [
	| allAccessesAndMapsToDB accessors |

	allAccessesAndMapsToDB := (self allDBAccesses asSet union: self allMaps asSet).
	accessors := allAccessesAndMapsToDB collect: #from.

	view shape rectangle fillColor: Color red.
	view interaction statusBar.
	view interaction noPopup.
	view interaction 
				dynamicEdgeToAll: [ :source | source mappedRelationalEntities asSet union: source accessedRelationalEntities asSet ]
				using: (ROLine new color: Color red).
	view nodes: ((accessors asSet select: [:each | each sourceLanguage isSmalltalk]) asSortedCollection: [:a :b | a name > b name]). 


	view shape rectangle fillColor: Color green.
	view interaction statusBar.
	view interaction noPopup.
	view interaction 
				dynamicEdgeToAll: [ :source | source mappedRelationalEntities asSet union: source accessedRelationalEntities asSet ]
				using: (ROLine new color: Color red).
	view nodes: ((accessors asSet select: [:each | each sourceLanguage isJava]) asSortedCollection: [:a :b | a name > b name]). 
	
	
	view shape rectangle.
	view interaction statusBar.
	view interaction noPopup.
	view interaction 
				dynamicEdgeToAll: [ :source | source mappedRelationalEntities asSet union: source accessedRelationalEntities asSet ]
				using: (ROLine new color: Color red).
	view nodes: ((accessors asSet select: [:each | each sourceLanguage isCobol]) asSortedCollection: [:a :b | a name > b name]).
	
	
	view shape rectangle.
	view interaction statusBar.
	view interaction noPopup.
	view interaction 
				dynamicEdgeToAll: [ :table | table sourceAccessorEntities asSet union: table mappedNamedEntities asSet ]
				using: (ROLine new color: Color red).
	view 
		nodes: ((allAccessesAndMapsToDB collect: #to) asSet asSortedCollection: [:a :b | a name > b name])
		forEach: [ :each | 
			view interaction nodraggable.
			view interaction noPopup.
			view shape label text: #name.
			view node: each ].


	view shape line fillColor: Color transparent.
	view interaction statusBar.
	view interaction noPopup.
	view
		edges: allAccessesAndMapsToDB
		from: #from
		to: #to.

	view layout: (ROGraphVizReusableLayout new neato reuseOrSaveLayout: 'DBAccessesAndMappingsConstellation') "forceNew".
]
