Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> accessDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #accessedEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
	directionSymbol = #accessorEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #dbAccesses or #sourceAccessors'.
]

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> addDBAccess: aDBAccess [
	self dbAccesses add: aDBAccess
]

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> dbAccesses [
	<MSEProperty: #dbAccesses type: #MJFAMIXDBAccess opposite: #accessorEntity> <multivalued>  <derived>
	<MSEComment: 'Database access relationship.'>
	
	^self privateState attributeAt: #dbAccesses ifAbsentPut: [FMMultivalueLink on: self opposite: #accessorEntity:].
]

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> groupNumber [
	<MSEProperty: #groupNumber type: #Number>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeAt: #groupNumber ifAbsent: [nil]
]

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> groupNumber: anInteger [

	^self privateState attributeAt: #groupNumber put: anInteger
]
