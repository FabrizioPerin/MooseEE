Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOQMNOM [
	
	<property: #'R_NOQM_NOM'
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>
	^self lookUpPropertyNamed: #'R_NOQM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOTMNOM [
	<property: #'R_NOTM_NOM'
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>
	^self lookUpPropertyNamed: #'R_NOTM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]
