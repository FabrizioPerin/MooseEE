Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> addMaps: aMapping [
	self maps add: aMapping
]

{ #category : #'*Moose-JEE' }
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

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> mappedRelationalEntities [
	^self mapDirection:  #mapTarget on: self mooseModel allMaps.
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> maps [
	<MSEProperty: #maps type: #MJFAMIXMapping opposite: #mapSource> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeAt: #maps ifAbsent: [FMMultivalueLink on: self opposite: #mapSource:].
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> maps: aMapping [
	self maps value: aMapping
]
