Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> accessDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #accessedEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
	directionSymbol = #accessorEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #dbAccesses or #sourceAccessors'.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> accessedRelationalEntities [
	^self accessDirection:  #accessedEntity on: self mooseModel allDBAccesses
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> accessorSourceEntities [
	^self accessDirection:  #accessorEntity on: self mooseModel allDBAccesses
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> addDBAccess: aDBAccess [
	self dbAccesses add: aDBAccess
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> dbAccesses [
	<MSEProperty: #dbAccesses type: #MJFAMIXDBAccess opposite: #accessorEntity> <multivalued>  <derived>
	<MSEComment: 'Database access relationship.'>
	
	^self privateState attributeAt: #dbAccesses ifAbsentPut: [FMMultivalueLink on: self opposite: #accessorEntity:].
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> groupNumber [
	<MSEProperty: #groupNumber type: #Number>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeAt: #groupNumber ifAbsent: [nil]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXSourcedEntity >> groupNumber: anInteger [

	^self privateState attributeAt: #groupNumber put: anInteger
]
