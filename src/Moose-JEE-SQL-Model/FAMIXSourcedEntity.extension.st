Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*moose-jee-sql-model' }
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

{ #category : #'*moose-jee-sql-model' }
FAMIXSourcedEntity >> accessedRelationalEntities [
	^self accessDirection:  #accessedEntity on: self mooseModel allDBAccesses
]

{ #category : #'*moose-jee-sql-model' }
FAMIXSourcedEntity >> accessorSourceEntities [
	^self accessDirection:  #accessorEntity on: self mooseModel allDBAccesses
]

{ #category : #'*moose-jee-sql-model' }
FAMIXSourcedEntity >> addDBAccess: aDBAccess [
	self dbAccesses add: aDBAccess
]

{ #category : #'*moose-jee-sql-model' }
FAMIXSourcedEntity >> dbAccesses [
	<MSEProperty: #dbAccesses type: #MJFAMIXDBAccess opposite: #accessorEntity> <multivalued>  <derived>
	<MSEComment: 'Database access relationship.'>
	
	^self privateState attributeAt: #dbAccesses ifAbsentPut: [FMMultivalueLink on: self opposite: #accessorEntity:].
]
