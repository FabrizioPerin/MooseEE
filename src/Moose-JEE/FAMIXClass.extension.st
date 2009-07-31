Extension { #name : #FAMIXClass }

{ #category : #'*Moose-JEE' }
FAMIXClass >> parentEJBBean: aBean [

	^self privateState attributeSet: #parentEJBBean value: aBean
]
