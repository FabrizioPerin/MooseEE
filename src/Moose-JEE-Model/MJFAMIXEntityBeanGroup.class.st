Class {
	#name : #MJFAMIXEntityBeanGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup class >> annotation [

	<MSEClass: #MJFAMIXEntityBeanGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'JEAs Visualizations'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.

]
