Extension { #name : #FAMIXNamespace }

{ #category : #'*moose-jee-rimacasestudy' }
FAMIXNamespace >> printNameOn: aStream [
	
	self belongsTo ifNotNil: [:parent |
		parent printNameOn: aStream.
		aStream nextPut: $. ].
	self name ifNotNil: [ aStream nextPutAll: self name ].
	
]
