Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOQMNOM [
	<property: #RNOQMNOM
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>
	^self lookUpPropertyNamed: #RNOQMNOM computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOTMNOM [
	<property: #RNOTMNOM
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>
	^self lookUpPropertyNamed: #RNOTMNOM computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]
