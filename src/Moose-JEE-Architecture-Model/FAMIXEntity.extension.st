Extension { #name : #FAMIXEntity }

{ #category : #'*moose-jee-architecture-model' }
FAMIXEntity >> addContainerComponent: aBAContainment [
	self containerComponents add: aBAContainment
]

{ #category : #'*moose-jee-architecture-model' }
FAMIXEntity >> clearContainerComponents [
	
	^self privateState attributeAt: #containerComponents put: [FMMultivalueLink on: self opposite: #containedElement:].
]

{ #category : #'*moose-jee-architecture-model' }
FAMIXEntity >> containerComponents [
	<MSEProperty: #containerComponents type: #MEEContainment opposite: #containedElement> <multivalued>  <derived>
	<MSEComment: 'Containment relationships.'>
	
	^self privateState attributeAt: #containerComponents ifAbsentPut: [FMMultivalueLink on: self opposite: #containedElement:].
]
