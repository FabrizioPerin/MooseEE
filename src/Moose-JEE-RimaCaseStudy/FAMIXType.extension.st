Extension { #name : #FAMIXType }

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> accessedTypes [
	^(self accesses reject: [:access | access variable isNil]) collect: [:access | access variable  belongsTo].  
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> accesses [
	^self methods flatCollect: #accesses  
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
	^(self returnedTypes union: (self invokedTypes union: self accessedTypes)) asSet. 
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> referencingTypes [
	
	^self privateState 
		cacheAt: #referencingTypes 
		ifAbsentPut: [self privateReferencingTypes]
]

{ #category : #'*Moose-JEE-RimaCaseStudy' }
FAMIXType >> returnedTypes [ 
	^(self methods select: [:each | each declaredType isNil not]) reject: #isStub.
]
