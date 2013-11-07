Extension { #name : #FAMIXType }

{ #category : #'*moose-jee-core-model' }
FAMIXType >> invokedClasses [
	<navigation: 'Invoked classes'>
	
	| classes |
	
	classes := (self methods flatCollect: #invokedCandidates) collect: #belongsTo.
	^ classes asSet asMooseGroup
]

{ #category : #'*moose-jee-core-model' }
FAMIXType >> invokingClasses [
	<navigation: 'Invoking classes'>
	
	| classes |
	
	classes := (self methods flatCollect: #invokingMethods) collect: #belongsTo.
	^ classes asSet asMooseGroup
]

{ #category : #'*moose-jee-core-model' }
FAMIXType >> invokingClassesWithThreshold: aNumber [
	<navigation: 'Invoking classes with threshold'>
	
	| classes |
	
	classes := ( self methods flatCollect: [ :each | each invokingMethodsWithThreshold: aNumber ] ) collect: #belongsTo.
	^ classes asSet asMooseGroup
]
