Extension { #name : #FAMIXEntity }

{ #category : #'*moose-jee-architecture-model' }
FAMIXEntity >> incomingComponentAssociation [
	<MSEProperty: #incomingComponentAssociation type: #MEEComponentAssociation opposite: #target> <multivalued>  <derived>
	<MSEComment: 'Association with another component'>
	
	^self privateState attributeAt: #incomingComponentAssociation ifAbsentPut: [FMMultivalueLink on: self opposite: #target:].
]

{ #category : #'*moose-jee-architecture-model' }
FAMIXEntity >> outgoingComponentAssociation [
	<MSEProperty: #outgoingComponentAssociation type: #MEEComponentAssociation opposite: #source> <multivalued>  <derived>
	<MSEComment: 'Association with another component'>
	
	^self privateState attributeAt: #outgoingComponentAssociation ifAbsentPut: [FMMultivalueLink on: self opposite: #source:].
]
