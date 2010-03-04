Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Moose-JEE' }
FAMIXSourcedEntity >> groupNumber [
	<MSEProperty: #groupNumber type: #Number>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeGet: #groupNumber default: [nil]
]

{ #category : #'*Moose-JEE' }
FAMIXSourcedEntity >> groupNumber: anInteger [

	^self privateState attributeSet: #groupNumber value: anInteger
]
