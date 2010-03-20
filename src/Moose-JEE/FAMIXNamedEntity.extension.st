Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> addDefines: aMapping [
	self defines add: aMapping
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> defines [
	<MSEProperty: #defines type: #FAMIXMapping opposite: #maps> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeGet: #defines default:[FMMultivalueLink on: self opposite: #maps:].
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> defines: aMapping [
	self defines value: aMapping
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> mapDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #maps
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
	directionSymbol = #mapped
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #maps or #mapped'.
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> mappedRelationalEntity [
	^self mapDirection:  #mapped on: self mooseModel allMaps.
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> mappedTables [
	^self defines collect: [:map | map mapped].
]
