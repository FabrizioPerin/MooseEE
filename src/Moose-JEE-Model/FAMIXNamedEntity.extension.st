Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> addIncomingDerivedDependency: aDerivedDependency [
	self incomingDerivedDependency add: aDerivedDependency
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> addMaps: aMapping [
	self maps add: aMapping
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> addOutgoingDerivedDependency: aDerivedDependency [
	self outgoingDerivedDependency add: aDerivedDependency
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> derivedDependenciesDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #source
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
	directionSymbol = #target
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #outgoingDerivedDependency or #incomingDerivedDependency'.
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> incomingDerivedDependency [
	<MSEProperty: #incomingDerivedDependency type: #MJFAMIXDerivedDependency opposite: #target> <multivalued>  <derived>
	<MSEComment: 'Dependency derived from another dependency.'>
	
	^self privateState attributeAt: #incomingDerivedDependency ifAbsentPut: [FMMultivalueLink on: self opposite: #target:].
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> mapDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #mapSource
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
	directionSymbol = #mapTarget
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #maps or #mapped'.
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> mappedRelationalEntities [
	^self mapDirection:  #mapTarget on: self mooseModel allMaps.
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> maps [
	<MSEProperty: #maps type: #MJFAMIXMapping opposite: #mapSource> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeAt: #maps ifAbsentPut: [FMMultivalueLink on: self opposite: #mapSource:].
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> outgoingDerivedDependency [
	<MSEProperty: #outgoingDerivedDependency type: #MJFAMIXDerivedDependency opposite: #source> <multivalued>  <derived>
	<MSEComment: 'Dependency derived from another dependency.'>
	
	^self privateState attributeAt: #outgoingDerivedDependency ifAbsentPut: [FMMultivalueLink on: self opposite: #source:].
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> removePointersToMaps [
	
	^self privateState attributeAt: #maps put: (FMMultivalueLink on: self opposite: #mapSource:).
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> viewDerivedDependenciesConstellation [

	"<menuItem: 'DTOs Constellation' category: 'JEAs Visualizations WORKINGON'>"
	
	| view |
	view := MOViewRenderer new.
	self viewDerivedDependenciesConstellationOn: view.
	^ view openWithStatusbar title: 'Derived Dependencies Constellation'
	
]

{ #category : #'*Moose-JEE-Model' }
FAMIXNamedEntity >> viewDerivedDependenciesConstellationOn: aView [
	| derivedConnections invoking allDirectedDependencies allNotDirectedDependencies |

	derivedConnections := OrderedCollection with: self.
	derivedConnections addAll: (self derivedDependenciesDirection: #target on: self mooseModel allDerivedDependencies).
	derivedConnections addAll: (self derivedDependenciesDirection: #source on: self mooseModel allDerivedDependencies).
	
	aView shape label text: #name; fontSize: 8.
	aView interaction menu: #mooseMenuMorph.
	aView nodes: derivedConnections asSet.
	
	allDirectedDependencies := self mooseModel allDerivedDependencies select: [:dd | dd isDirected].
	allNotDirectedDependencies := self mooseModel allDerivedDependencies reject: [:dd | dd isDirected].


	"View Edges"
	aView interaction popupText: [:dd | dd asString , String eol , String eol , dd rationale ].
	aView shape line color: Color veryLightGray.
	aView edges: allDirectedDependencies from: #source to: #target.
	
	aView interaction popupText: [:dd | dd asString , String eol , String eol , dd rationale ].
	aView shape line color: Color veryLightGray.
	aView edges: allNotDirectedDependencies from: #source to: #target.
	
	aView interaction popupText: [:dd | dd asString , String eol , String eol , dd rationale ].
	aView shape line color: Color veryLightGray.
	aView edges: allNotDirectedDependencies from: #target to: #source.

	aView graphvizLayout fdp.
]
