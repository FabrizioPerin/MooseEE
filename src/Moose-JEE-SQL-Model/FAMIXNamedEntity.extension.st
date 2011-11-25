Extension { #name : #FAMIXNamedEntity }

{ #category : #'*moose-jee-sql-model' }
FAMIXNamedEntity >> addMaps: aMapping [
	self maps add: aMapping
]

{ #category : #'*moose-jee-sql-model' }
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

{ #category : #'*moose-jee-sql-model' }
FAMIXNamedEntity >> mappedRelationalEntities [
	^self mapDirection:  #mapTarget on: self mooseModel allMaps.
]

{ #category : #'*moose-jee-sql-model' }
FAMIXNamedEntity >> maps [
	<MSEProperty: #maps type: #FAMIXMapping opposite: #mapSource> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeAt: #maps ifAbsentPut: [FMMultivalueLink on: self opposite: #mapSource:].
]

{ #category : #'*moose-jee-sql-model' }
FAMIXNamedEntity >> removePointersToMaps [
	
	^self privateState attributeAt: #maps put: (FMMultivalueLink on: self opposite: #mapSource:).
]
