Class {
	#name : #MEEArchitecturalComponentTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Architecture-Model'
}

{ #category : #accessing }
MEEArchitecturalComponentTests >> testComponentCreation [

	| aComponent |
	
	aComponent := MEEArchitecturalComponent named: '1'.
	
	self assert: (aComponent isMemberOf: MEEArchitecturalComponent).
	self assert: aComponent name equals: '1'.
]

{ #category : #accessing }
MEEArchitecturalComponentTests >> testContainedElement [
	| aComponent containment |
	
	aComponent := MEEArchitecturalComponent named: '1'.
	containment := MEEContainment new.
	
	self assert: (aComponent containedElements isMemberOf: FMMultivalueLink). 
	self assert: aComponent containedElements size equals: 0.	
	
	aComponent addContainedElement: containment.
	
	self assert: aComponent containedElements size equals: 1.
	self assert: (aComponent containedElements first isMemberOf: MEEContainment).

]
