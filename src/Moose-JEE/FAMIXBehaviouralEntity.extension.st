Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Moose-JEE' }
FAMIXBehaviouralEntity >> invokedCandidates [
	^self outgoingInvocations flatCollect: [:each | each candidates].
]
