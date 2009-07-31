Extension { #name : #FAMIXMethod }

{ #category : #'*Moose-JEE' }
FAMIXMethod >> ejbTransactionType: aString [

	self privateState attributeSet: #ejbTransactionType value: aString
]
