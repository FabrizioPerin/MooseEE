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
