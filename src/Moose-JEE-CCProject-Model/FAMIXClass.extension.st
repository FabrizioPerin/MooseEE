Extension { #name : #FAMIXClass }

{ #category : #'*moose-jee-ccproject-model' }
FAMIXClass >> addClone: aMJCCPSource [
	
	^self clones add: aMJCCPSource.
]

{ #category : #'*moose-jee-ccproject-model' }
FAMIXClass >> cleanAllCloneSources [
	self privateState attributeAt: #clones put: (FMMultivalueLink on: self opposite: #codeClass:).
]

{ #category : #'*moose-jee-ccproject-model' }
FAMIXClass >> clones [
	<MSEProperty: #clones type: #MJCCPSource opposite: #codeClass> <multivalued>  <derived>
	<MSEComment: 'Association with the source elements describing the clones.'>
	
	^self privateState attributeAt: #clones ifAbsentPut: [FMMultivalueLink on: self opposite: #codeClass:].
]
