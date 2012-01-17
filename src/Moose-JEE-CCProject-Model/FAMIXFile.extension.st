Extension { #name : #FAMIXFile }

{ #category : #'*moose-jee-ccproject-model' }
FAMIXFile >> addCloneSource: aMJCCPSource [
	self cloneSources add: aMJCCPSource.
]

{ #category : #'*moose-jee-ccproject-model' }
FAMIXFile >> cleanAllCloneSources [
	self privateState attributeAt: #cloneSources put: (FMMultivalueLink on: self opposite: #codeFile:).
]

{ #category : #'*moose-jee-ccproject-model' }
FAMIXFile >> cloneSources [
	<MSEProperty: #cloneSources type: #MJCCPSource opposite: #codeFile> <multivalued>  <derived>
	<MSEComment: 'Association with the source elements describing the clones.'>
	
	^self privateState attributeAt: #cloneSources ifAbsentPut: [FMMultivalueLink on: self opposite: #codeFile:].
]
