Extension { #name : #FAMIXClass }

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> addAssociatedBlame: aMJBlameClassAssociation [
	^self associatedBlameFile add: aMJBlameClassAssociation
]

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> associatedBlameFile [
	<MSEProperty: #associatedBlameFile type: #MJBlameClassAssociation opposite: #targetClass> <multivalued>  <derived>
	<MSEComment: 'Association with the blame file of this class.'>
	
	^self privateState attributeAt: #associatedBlameFile ifAbsentPut: [FMMultivalueLink on: self opposite: #targetClass:].
]

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> associatedBlameFileOLD [
	self hasSourceAnchor
		ifTrue: [ 
			| blameFile |
			blameFile := self mooseModel allBlameFiles select: [ :bf | self sourceAnchor fileName endsWith: bf fileName ].
			blameFile isEmpty
				ifTrue: [ DialogWindow new alert: 'Could''t find the corresponding blame file' ]
				ifFalse: [^blameFile first]]
		ifFalse: [ DialogWindow new alert: 'The class doesn''t have a sourceAnchor' ]
]

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> developers [
	
	^self associatedBlameFile experts
]

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> expert [
	
	^self associatedBlameFile first target expert
]

{ #category : #'*moose-jee-gitlog-model' }
FAMIXClass >> showOwnershipPercentageDiagram [
	| developers loc diag |
	
	developers := self developers.
	loc := developers values inject: 0 into: [:sum :value | sum + value].
	
	diag := ESDiagramRenderer new.
	(diag pieDiagram)
		borderWidth: 1;
		radius: 200;
		models: developers keys;
		pieValue: [:dev | ((developers at: dev) / loc) * 100];
		color: #yourself;
		legendOrigin: 0@400;
		legendWidth: 600;
		displayLegend: true.

	^diag open
]
