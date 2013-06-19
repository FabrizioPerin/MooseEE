Extension { #name : #FAMIXEntity }

{ #category : #'*moose-jee-tiers-model' }
FAMIXEntity >> clearContainerLayer [
	
	^self privateState attributeAt: #containerLayer put: [nil].
]

{ #category : #'*moose-jee-tiers-model' }
FAMIXEntity >> containerLayer [
	<navigation: 'Container layer'>
	^self privateState attributeAt: #containerLayer ifAbsentPut: [nil].
]

{ #category : #'*moose-jee-tiers-model' }
FAMIXEntity >> containerLayer: aMJLayer [
	self privateState attributeAt: #containerLayer put: aMJLayer
]
