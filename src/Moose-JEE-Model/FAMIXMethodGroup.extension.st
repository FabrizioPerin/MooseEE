Extension { #name : #FAMIXMethodGroup }

{ #category : #'*Moose-JEE-Model' }
FAMIXMethodGroup >> deepCalledMethods [
	"This method starting from this group of method return an OrderedCollection with the method invocation chain that start with methods contained in this group"

	| cursor result |

	cursor := 1.
	result := OrderedCollection withAll: self.

	[cursor <= result size] whileTrue: [
		(result at: cursor) isNil ifFalse: [ result addAll: ( ( ( result at: cursor ) invokedCandidates ) reject: [ :each | ( result includes: each  ) or: [ each = nil ] ] ) ].
		cursor := cursor + 1.
	].

	^ result
]

{ #category : #'*Moose-JEE-Model' }
FAMIXMethodGroup >> deepCalleeMethods [
	"This method starting from this group of method return an OrderedCollection with the method invocation chain that end with methods contained in this group"
	| cursor result |

	cursor := 1.
	result := OrderedCollection withAll: self.

	[cursor <= result size] whileTrue: [
		(result at: cursor) isNil ifFalse: [  ( (result at: cursor) incomingInvocations ) 
											do: [:each |  ( result includes: ( each sender ) ) 
																ifFalse: [result add: each sender ] ] ].
		cursor := cursor + 1.
	].

	^ result
]

{ #category : #'*Moose-JEE-Model' }
FAMIXMethodGroup >> deepCalleeMethodsWithoutTransactionPath [

	| cursor temp result aMethodGroup |

	cursor := 1.
	temp  := OrderedCollection withAll: self.
	result := OrderedCollection new.
	aMethodGroup := FAMIXMethodGroup new.

	"Starting form root element"

	[cursor <= temp size] whileTrue: [
		(temp at: cursor) isNil ifFalse: [ 
								( (temp at: cursor) incomingInvocations ) 
									do: [:each | ( each sender doesSupportTransaction and:[ ( each sender startATransaction or: [ each sender doesOverrideAMethodInvolveInATransaction ] ) ] ) 
																	ifFalse: [ ( temp includes: ( each sender ) ) 
																					ifFalse: [ temp add: ( each sender ) ] ] 
										].
							].
		cursor := cursor + 1.
	].

	( temp reversed ) do: [ :method | method couldBeAnEntryPoint ifTrue: [ aMethodGroup add: method ] ].
	result addAll: aMethodGroup deepCalledMethods.
  	result := result intersection: temp.

	^ result
]
