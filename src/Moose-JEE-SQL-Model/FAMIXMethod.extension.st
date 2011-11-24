Extension { #name : #FAMIXMethod }

{ #category : #'*moose-jee-sql-model' }
FAMIXMethod >> ownedTable [
	self flag: #TODOTest.
	^self privateState attributeAt: #ownedTable ifAbsent: [nil]
]

{ #category : #'*moose-jee-sql-model' }
FAMIXMethod >> ownedTable: anObject [

	self flag: #TODOTest.
	self privateState attributeAt: #ownedTable put: anObject
]
