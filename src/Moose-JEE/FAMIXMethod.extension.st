Extension { #name : #FAMIXMethod }

{ #category : #'*Moose-JEE' }
FAMIXMethod >> allInvocationsBetweenHereTo: anotherMethod [

	| invocationChain |

	invocationChain := self deepCalledMethods asOrderedCollection.
	( invocationChain includes: anotherMethod ) 
		ifTrue: [ ^ ( ( invocationChain flatCollect: [ :each | each outgoingInvocations ] ) intersection: ( anotherMethod deepCalleeMethods flatCollect: [ :each | each incomingInvocations ] ) ) ]
		ifFalse: [ 
				invocationChain := self deepCalleeMethods asOrderedCollection.
				( invocationChain includes: anotherMethod ) ifTrue: [ ^ ( ( invocationChain flatCollect: [ :each | each incomingInvocations ] ) intersection: ( anotherMethod deepCalledMethods flatCollect: [ :each | each outgoingInvocations ] ) ) ]  ].

	^ OrderedCollection new
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> allMethodsTouchFromHereTo: anotherMethod [

	| methodInvocationChain |
	
	self flag: #TODOTests.
	
	methodInvocationChain := self deepCalledMethods asOrderedCollection.

	( methodInvocationChain includes: anotherMethod ) ifFalse: [ ^ OrderedCollection new ].

	^ methodInvocationChain intersection: ( anotherMethod deepCalleeMethods asOrderedCollection )
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> callsJavaSqlPackage [

	| result invokedMethodsCollection |
	
	result := OrderedCollection new.
	invokedMethodsCollection := self invokedCandidates.

	invokedMethodsCollection isEmpty ifFalse: [ 
		invokedMethodsCollection do: [:invokedMethod | 
			(invokedMethod isNil not and: [ invokedMethod belongsTo belongsTo name = #sql and: [ invokedMethod belongsTo belongsTo belongsTo name = #java ]] ) ifTrue: [ 
				result isEmpty ifTrue: [result add: self] ] ]].

	^result
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> couldBeAnEntryPoint [
	^ self incomingInvocations isEmpty 
			ifFalse: [ self incomingInvocations 
								allSatisfy: [ :method | '.*test.*' asRegex matches: method name asLowercase ] ]
			ifTrue: [true]				
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> deepCalledMethods [
	"This method starting from this group of method return an OrderedCollection with the method invocation chain that start with methods contained in this group"

	| cursor result |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.

	[cursor <= result size] whileTrue: [
		(result at: cursor) isNil ifFalse: [ result addAll: ( ( result at: cursor ) invokedCandidates reject: [ :each | ( result includes: each ) or: [ each = nil ] ] ) ].
		cursor := cursor + 1.
	].

	^ result
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> deepCalleeMethods [
	"This message return an OrderedCollection of methods invoked starting from itself. The collection contained also the starting method "
	| cursor result |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.

	[cursor <= result size] whileTrue: [
		(result at: cursor) isNil ifFalse: [ (result at: cursor) incomingInvocations do: [:each |  ( result includes: each sender ) ifFalse: [result add: each sender ]  ] ].
		cursor := cursor + 1.
	].

	^ result
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> deepCalleeMethodsWithoutTransactionPath [

	| cursor temp result aMethodGroup |

	cursor := 1.
	temp  := OrderedCollection new.
	result := OrderedCollection new.
	temp add: self.
	aMethodGroup := FAMIXMethodGroup new.

	[cursor <= temp size] whileTrue: [
		(temp at: cursor) isNil ifFalse: [ 
								( ( temp at: cursor ) incomingInvocations ) 
										do: [:each | (each sender doesSupportTransaction and:[ ( each sender startATransaction or: [ each sender doesOverrideAMethodInvolveInATransaction ] ) ] ) 
												ifFalse: [ ( temp includes: ( each sender ) ) 
															ifFalse: [ temp add: ( each sender ) ] ] ] ].
		cursor := cursor + 1.
	].

	( temp reversed ) do: [ :method | method couldBeAnEntryPoint ifTrue: [ aMethodGroup add: method ] ].
	result addAll: aMethodGroup deepCalledMethods.
  	result := result intersection: temp.

	^ result
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> doesCall: aSymbol [
	"Return true if self invokes a method called aSymbol"

	^ self invokedCandidates anySatisfy: [:invokedMethod | 
		invokedMethod isNil not and: [ invokedMethod name = aSymbol asSymbol ] ]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> doesExecuteAQuery [

	^( self doesCall: 'executeBatch' ) or: [ ( self doesCall: 'executeQuery' ) or: [ self doesCall: 'executeUpdate' ] ]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> doesOverrideAMethodInvolveInATransaction [

	"this message return true if the method extend a method that is part of a transaction because specified in the deployment descriptor"

	^ self belongsTo directSuperclasses anySatisfy: [ :class | 
		class isInterface not and: [
			( class methods anySatisfy: [ :method | 
				( method signature = self signature ) and: [ 
					method startATransaction ] ] ) 
		] 
	].
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> doesSupportTransaction [
	^(self ejbTransactionType = 'NotSupported' 
		or: [ self ejbTransactionType asString asLowercase = 'never'
			or:[ self ejbTransactionType asString asLowercase = 'not_supported' ] ] ) not
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> ejbTransactionType [
	"answer if the EJB transaction type is nil or not"

	^ self privateState attributeGet: #ejbTransactionType
							default: [nil].
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> ejbTransactionType: aString [

	self privateState attributeSet: #ejbTransactionType value: aString.
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> hasEJBTransactionAttribute [

	^self ejbTransactionType notNil
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> hasEJBTransactionAttributeThatSupportTransactions [

	^(self ejbTransactionType notNil) and: [self doesSupportTransaction ]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isADataLayerMethod [
	
	^ self callsJavaSqlPackage notEmpty or: [ self doesExecuteAQuery ].
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isADomainLayerMethod [
	
	^ ( self isADataLayerMethod or: [ self isAPresentationLayerMethod ] ) not
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isAPresentationLayerMethod [
	
	^ self name = #doPost or: [ self name = #doGet ]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isInvokedFromAPathThatSupportTransaction [
	^( self doesSupportTransaction and: [self deepCalleeMethods anySatisfy: [ :method | method ejbTransactionType = 'Supports' ] ] )
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isInvokedFromATransactionMethod [

	^( self doesSupportTransaction 
			and: [
					|tmp| 
					tmp := self deepCalleeMethods.
					tmp remove: self.
					tmp anySatisfy: [ :method | method startATransaction ] ] )
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isPartOfATransaction [

	^ self isInvokedFromATransactionMethod or: [ self doesOverrideAMethodInvolveInATransaction or: [ self isInvokedFromAPathThatSupportTransaction or: [ self startATransaction ] ] ]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> isPartOfAnUnsafeTransactionPath [

	^ ( ( self doesSupportTransaction ) and: [self deepCalleeMethodsWithoutTransactionPath anySatisfy: [ :method | method couldBeAnEntryPoint ] ] )
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> ownedTable [
	self flag: #TODOTest.
	^self privateState attributeGet: #ownedTable default: [nil]
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> ownedTable: anObject [

	self flag: #TODOTest.
	self privateState attributeSet: #ownedTable value: anObject
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> startATransaction [
	^ self ejbTransactionType = 'RequiresNew' or: [  self ejbTransactionType = 'Required' 
														or: [  self ejbTransactionType = 'REQUIRES_NEW'
															or: [self ejbTransactionType = 'REQUIRED' ] ] ].
]

{ #category : #'*Moose-JEE' }
FAMIXMethod >> startAUselessTransaction [
	^ ( ( ( self ejbTransactionType = 'RequiresNew' ) or: [ self ejbTransactionType = 'REQUIRES_NEW' ] ) 
		and: [ self isPartOfATransaction 
			and: [ self couldBeAnEntryPoint not ] ] )
]
