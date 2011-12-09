Extension { #name : #FAMIXType }

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> accessedTypes [
	| allAccessedType result |

	allAccessedType := self accessedVariables collect: [:access | access variable belongsTo]. 
	
	result := OrderedCollection new.
	
	result addAll: (allAccessedType select: [:each | each isKindOf: FAMIXType]).
	
	result addAll: ((allAccessedType select: [:each | each isMemberOf: FAMIXMethod]) collect: [:each | each belongsTo]).
	
	^result
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> accessedVariables [
	^self accesses reject: [:access | access variable isNil]
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> accesses [
	^self methods flatCollect: #accesses  
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> allReferedTypes [
	^(self returnedTypes union: (self invokedTypes union: self accessedTypes)). 
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> invokedTypes [
	^((self outgoingInvocations flatCollect: #candidates) collect: #belongsTo) reject: #isStub.        
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> privateReferencingTypes [
	^self mooseModel allTypes select: [:each|
		each referedTypes includes: self.
		]
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> referedTypes [
	| result |

	result := self returnedTypes.
	result addAll: self invokedTypes.
	result addAll: self accessedTypes.
	^result asSet. 
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> referencingTypes [
	
	^self privateState 
		cacheAt: #referencingTypes 
		ifAbsentPut: [self privateReferencingTypes]
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> returnedTypes [
	^((self methods reject: [:each | each declaredType isNil]) collect: #declaredType) reject: #isStub.
]
