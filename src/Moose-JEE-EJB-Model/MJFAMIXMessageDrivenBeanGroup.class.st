Class {
	#name : #MJFAMIXMessageDrivenBeanGroup,
	#superclass : #MEEAbstractGroup,
	#category : #'Moose-JEE-EJB-Model'
}

{ #category : #meta }
MJFAMIXMessageDrivenBeanGroup class >> annotation [

	<MSEClass: #MJFAMIXMessageDrivenBeanGroup super: #MEEAbstractGroup>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXMessageDrivenBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'JEAs Visualizations'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.
]
