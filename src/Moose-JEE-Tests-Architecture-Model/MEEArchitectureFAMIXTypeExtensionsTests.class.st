Class {
	#name : #MEEArchitectureFAMIXTypeExtensionsTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Architecture-Model'
}

{ #category : #accessing }
MEEArchitectureFAMIXTypeExtensionsTests >> testContainerComponent [
	| aType containment |
	
	aType := FAMIXType new name: '1'.
	containment := MEEContainment new.
	
	self assert: (aType containerComponents isMemberOf: FMMultivalueLink). 
	self assert: aType containerComponents size equals: 0.	
	
	aType addContainerComponent: containment.
	
	self assert: aType containerComponents size equals: 1.
	self assert: (aType containerComponents first isMemberOf: MEEContainment).

]
