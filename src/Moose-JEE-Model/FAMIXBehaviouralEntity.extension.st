Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Moose-JEE-Model' }
FAMIXBehaviouralEntity >> invokedCandidates [
	^self outgoingInvocations flatCollect: [:each | each candidates].
]
