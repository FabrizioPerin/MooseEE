Class {
	#name : #MJFAMIXEntityBeanGroup,
	#superclass : #MJGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup class >> annotation [

	<MSEClass: #EntityBeanGroup super: #Group>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXEntityBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'JEAs Visualizations'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.

]
