Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXBehaviouralEntity >> invokedCandidates [
	^self outgoingInvocations flatCollect: [:each | each candidates].
]
