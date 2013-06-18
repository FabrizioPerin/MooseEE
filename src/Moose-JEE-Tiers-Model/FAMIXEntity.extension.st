Extension { #name : #FAMIXEntity }

{ #category : #'*moose-jee-tiers-model' }
FAMIXEntity >> containerLayer [
	
	^self
		lookUpPropertyNamed: #containerLayer
		computedAs: [ self mooseModel allLayers detect: [ :each | each containedElements includes: self ] ifNone: [nil] ]
	
]
