Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> definedRelationalEntity [

	^self privateState attributeGet: #defines default:[nil].
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> definedRelationalEntity: aFAMIXMapping [

	^self privateState attributeSet: #defines value: aFAMIXMapping
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> defines [
	<MSEProperty: #defines type: #FAMIXMapping opposite: #targetRelationalEntity> <multivalued> 
	<MSEComment: 'Map relationship.'>
	
	^self definedRelationalEntity
]

{ #category : #'*Moose-JEE' }
FAMIXNamedEntity >> defines: aFAMIXMapping [
	self definedRelationalEntity: aFAMIXMapping
]
