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
