Extension { #name : #FAMIXType }

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> accessedTypes [
	^(self accesses reject: [:access | access variable isNil]) collect: [:access | access variable  belongsTo].  
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> accesses [
	^self methods flatCollect: #accesses  
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> invokedTypes [
	^((self outgoingInvocations flatCollect: #candidates) collect: #belongsTo) reject: #isStub.        
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> privateReferencingTypes [
	^self mooseModel allTypes select: [:each|
		each referedTypes includes: self.
		]
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> referedTypes [
	^(self returnedTypes union: (self invokedTypes union: self accessedTypes)) asSet. 
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> referencingTypes [
	
	^self privateState 
		cacheAt: #referencingTypes 
		ifAbsentPut: [self privateReferencingTypes]
]

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
FAMIXType >> returnedTypes [ 
	^(self methods select: [:each | each declaredType isNil not]) reject: #isStub.
]
