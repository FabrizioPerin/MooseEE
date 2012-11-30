Extension { #name : #FAMIXType }

{ #category : #'*moose-jee-architecture-model' }
FAMIXType >> addContainerComponent: aBAContainment [
	self containerComponents add: aBAContainment
]

{ #category : #'*moose-jee-architecture-model' }
FAMIXType >> clearContainerComponents [
	
	^self privateState attributeAt: #containerComponents put: [FMMultivalueLink on: self opposite: #containedElement:].
]

{ #category : #'*moose-jee-architecture-model' }
FAMIXType >> containerComponents [
	<MSEProperty: #containerComponents type: #MEEContainment opposite: #containedElement> <multivalued>  <derived>
	<MSEComment: 'Containment relationships.'>
	
	^self privateState attributeAt: #containerComponents ifAbsentPut: [FMMultivalueLink on: self opposite: #containedElement:].
]
