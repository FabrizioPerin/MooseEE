Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> groupNumber [
	<MSEProperty: #groupNumber type: #Number>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeAt: #groupNumber ifAbsent: [nil]
]

{ #category : #'*Moose-JEE-Model' }
FAMIXSourcedEntity >> groupNumber: anInteger [

	^self privateState attributeAt: #groupNumber put: anInteger
]
