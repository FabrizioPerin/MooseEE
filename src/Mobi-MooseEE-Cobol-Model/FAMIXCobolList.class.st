Class {
	#name : #FAMIXCobolList,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'outgoingCalls',
		'incomingCalls',
		'ast'
	],
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolList class >> annotation [
	<MSEClass: #CobolList super: #FAMIXNamedEntity>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> accessTable: aDbTable withField: aFileName [
	| nodes |
	
	nodes := self ast deepFlatten select: [ :each | each isMemberOf: ExecSQLNode ].

	nodes
		do: [ :node | 
			| sqlnodes |
	
			sqlnodes := (node ast deepFlatten select: [ :each | each isKindOf: SQLASTNode ]).
						
			sqlnodes do: [ :sqlnode |
				( ( sqlnode isMemberOf: SQLSelectStmtNode )
				or: [ ( sqlnode isMemberOf: SQLUpdateStatementNode )
					or: [ sqlnode isMemberOf: SQLDeleteStmtNode ] ] )
					ifTrue: [			
						sqlnode where isNil
							ifFalse: [ sqlnode where isString
								ifTrue: [ 
									( ( sqlnode where findString: aFileName ) > 0 )
										ifTrue: [ ^ true ] ] ] ] ] ].
	^ false
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> addIncomingCalls: aCobolCall [
	incomingCalls add: aCobolCall
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> addOutgoingCalls: aCobolCall [
	outgoingCalls add: aCobolCall
]

{ #category : #accessing }
FAMIXCobolList >> ast [
	^ ast
]

{ #category : #accessing }
FAMIXCobolList >> ast: anObject [
	ast := anObject
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXScopingEntity> <derived>
	<MSEComment: 'Generic accessor to the container for any named entity. This attribute is refined by each subclass in the model'>
	
	^self namespaceScope 
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> calledCobolLists [
	<navigation: 'Called cobol lists'>
	
	| cobolLists |
	
	cobolLists := self outgoingCalls collect: #target.
	^ cobolLists asSet asMooseGroup
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> callingCobolLists [
	<navigation: 'Calling cobol lists'>
	
	| cobolLists |
	
	cobolLists := self incomingCalls collect: #source.
	^ cobolLists asSet asMooseGroup
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> computeRelevantHierarchy [
	| layers |

	layers := Dictionary new.
	
	self computeRelevantHierarchyAndFill: layers.

	^ layers
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> computeRelevantHierarchyAndFill: aDictionary [
	| initialCobolElements |
	
	initialCobolElements := self withDeepCalledCobolLists asSet union: self withDeepCallingCobolLists asSet.
	
	initialCobolElements := initialCobolElements union: (initialCobolElements flatCollect: [:each | each dbAccesses collect: #accessedEntity]) asSet.

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

{ #category : #'as yet unclassified' }
FAMIXCobolList >> incomingCalls [
	<MSEProperty: #incomingCalls type: #FAMIXCobolCall opposite: #target> <multivalued> <derived>
	<MSEComment: 'Incoming calls sent by this cobol list.'>
	
	^incomingCalls
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> incomingCalls: incomingCallsCollection [
	
	incomingCalls value: incomingCallsCollection.
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> initialize [
	super initialize.
	
	outgoingCalls := FMMultivalueLink 
		on: self
		opposite: #source:.
	incomingCalls := FMMultivalueLink 
		on: self
		opposite: #target:.
]

{ #category : #metrics }
FAMIXCobolList >> numberOfCommentedLines [
	<MSEProperty: #numberOfCommentedLines type: #Number>
	<derived>
	<MSEComment: 'The number of commented lines of code'>

	^self
		lookUpPropertyNamed: #numberOfCommentedLines
		computedAs: [ 
			self ast isNil
				ifFalse: [ 
					| result commentedLines |
					commentedLines := self ast select: [:each | each isMemberOf: CobolCommentNode ].
					result := commentedLines size.
					self ast removeAll: commentedLines.
					commentedLines := nil.
					result  ]
				ifTrue: [ ( ( self sourceLanguage parser parse: self sourceText) select: [:each | each isMemberOf: CobolCommentNode ] ) size ] ]
]

{ #category : #metrics }
FAMIXCobolList >> numberOfEmptyLines [
	"<MSEProperty: #numberOfEmptyLines type: #Number>
	<derived>
	<MSEComment: 'The number of empty lines of code'>"

	^self
		lookUpPropertyNamed: #numberOfEmptyLines
		computedAs: [
			self ast isNil
				ifFalse: [ ( self ast select: [:each | each isMemberOf: EmptyLineNode ] ) size ]
				ifTrue: [ ( ( self sourceLanguage parser parse: self sourceText) select: [:each | each isMemberOf: EmptyLineNode ] ) size ] ]
]

{ #category : #metrics }
FAMIXCobolList >> numberOfLinesOfCode [
	<MSEProperty: #numberOfLinesOfCode type: #Number>
	<derived>
	<MSEComment: 'The number of lines of code in a class'>

	^self
		lookUpPropertyNamed: #numberOfLinesOfCode
		computedAs: [self sourceText lineCount]
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> outgoingCalls [
	<MSEProperty: #outgoingCalls type: #FAMIXCobolCall opposite: #source> <multivalued> <derived>
	<MSEComment: 'Outgoing calls sent by this cobol list.'>
	
	^outgoingCalls
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> outgoingCalls: outgoingCallsCollection [
	
	outgoingCalls value: outgoingCallsCollection.
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> printOn: aStream [
	
	self name isNil ifFalse: [ aStream nextPutAll: self name ].
	
	aStream nextPutAll: ' (Cobol Entity)'
]

{ #category : #view }
FAMIXCobolList >> viewCobolCallsTwoWaysHirarchy [
	<menuItem: 'View Cobol calls two ways hierarchy' category: 'Mobi Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewCobolCallsTwoWaysHirarchyOn:  aView.
	aView open.
]

{ #category : #view }
FAMIXCobolList >> viewCobolCallsTwoWaysHirarchyIn: composite [
	<moosePresentationOrder: 277>
	composite roassalWithoutInertia
		title: 'Two ways call hierarchy';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColors;
		painting: [ :view :each | each mooseInterestingEntity viewCobolCallsTwoWaysHirarchyOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolList ]
]

{ #category : #view }
FAMIXCobolList >> viewCobolCallsTwoWaysHirarchyOn: aView [
	| hierarchy |

	hierarchy := ( self withDeepCalledCobolLists asSet union: self withDeepCallingCobolLists asSet ) asMooseGroup.
	hierarchy remove: self.

	aView shape rectangle withText: #name; width: 80.
	aView nodes: hierarchy.
	
	aView shape rectangle withText: #name; color: Color red; width: 80.
	aView node: self.
	

	aView 
		edges: self mooseModel allCobolCalls
		from: #source
		to: #target.

	aView treeLayout layered
]

{ #category : #view }
FAMIXCobolList >> viewCobolListDatabaseAcceses [
	<menuItem: 'View Cobol list database accesses' category: 'Mobi Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewCobolListDatabaseAccessesOn:  aView.
	aView open.
]

{ #category : #view }
FAMIXCobolList >> viewCobolListDatabaseAccessesIn: composite [
	<moosePresentationOrder: 264>
	composite roassalWithoutInertia 
		title: 'Database accesses';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewCobolListDatabaseAccessesOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolList ]
]

{ #category : #view }
FAMIXCobolList >> viewCobolListDatabaseAccessesOn: aView [

	aView shape rectangle withText: #name; width: 80.
	aView node: self.
	aView shape rectangle withText: #name; width: 80.
	aView nodes: self accessedRelationalEntities asSet.

	aView 
		edges: self mooseModel allDBAccesses
		from: #from
		to: #to.

	aView treeLayout
]

{ #category : #view }
FAMIXCobolList >> viewHierarchyPerLayersIn: composite [
	<moosePresentationOrder: 276>
	composite roassalWithoutInertia
		title: 'Layers per application';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewHierarchyPerLayersOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXCobolList ]
]

{ #category : #view }
FAMIXCobolList >> viewHierarchyPerLayersOn: view [
	| layers normalizer |
	
	layers := self computeRelevantHierarchy.
	
	normalizer := RTMultiLinearColor
		withCommand: [ :comp | (comp containerComponents collect: #containerComponent) asSet ].
	
	(MJFAMIXLayerGroup withAll: layers keys) viewLayersSubsets: layers perApplicationUsing: normalizer on: view
	

]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> withDeepCalledCobolLists [

	| cursor result calledCobolLists |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		calledCobolLists := ( result at: cursor ) calledCobolLists.
		result addAll: ( calledCobolLists reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]

{ #category : #'as yet unclassified' }
FAMIXCobolList >> withDeepCallingCobolLists [

	| cursor result callingCobolLists |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		callingCobolLists := ( result at: cursor ) callingCobolLists.
		result addAll: ( callingCobolLists reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]
