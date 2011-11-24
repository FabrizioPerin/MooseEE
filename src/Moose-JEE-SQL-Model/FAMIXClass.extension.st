Extension { #name : #FAMIXClass }

{ #category : #'*moose-jee-sql-model' }
FAMIXClass >> accessATable [
	<MSEProperty: #accessATable type: #Boolean>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState 
		attributeAt: #accessATable 
		ifAbsent: [
			| val |
			val := self mappedRelationalEntities size > 0.
			"self accessATable: val."
			val.]
]

{ #category : #'*moose-jee-sql-model' }
FAMIXClass >> accessATable: aBooleanOrNil [
	
	^self privateState attributeAt: #accessATable put: aBooleanOrNil
]
