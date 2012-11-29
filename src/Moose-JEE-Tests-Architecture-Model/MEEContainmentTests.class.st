Class {
	#name : #MEEContainmentTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Architecture-Model'
}

{ #category : #tests }
MEEContainmentTests >> testAnnotation [
	self assert: MEEContainment annotation == MEEContainment.
]

{ #category : #testsOnJEEModel }
MEEContainmentTests >> testBAContainmentCreation [
	
	| containment |
		
	containment := MEEContainment new.
	
	self assert: (containment isMemberOf: MEEContainment).
	self assert: (containment containerComponent = nil).
	self assert: (containment containedElement = nil).
]

{ #category : #testsOnJEEModel }
MEEContainmentTests >> testBAContainmentCreationWithComponentAndElement [
	
	| baComp type containment |
	
	baComp := MEEArchitecturalComponent new.
	type := FAMIXType new name: #Whatever.
	
	containment := MEEContainment new containerComponent: baComp; containedElement: type.
	
	baComp addContainedElement: containment.
	type addContainerComponent:  containment.
	
	self assert: (containment isMemberOf: MEEContainment).
	self assert: (containment containedElement = type).
	self assert: (containment containerComponent = baComp).
	self assert: (containment from = baComp).
	self assert: (containment to = type).
	  
	
	
]

{ #category : #testsOnJEEModel }
MEEContainmentTests >> testPrintOn [ 
	
	| aComponent aType aContainer stream |
	
	aComponent := MEEArchitecturalComponent new.
	aType := FAMIXType new name: #Whatever.
	
	aContainer := MEEContainment new containerComponent: aComponent; containedElement: aType.
	
	aComponent addContainedElement: aContainer.
	aType addContainerComponent: aContainer.
	
	self assert: (aContainer isMemberOf: MEEContainment).
	self assert: (aContainer containerComponent = aComponent).
	self assert: (aContainer containedElement = aType).
	self assert: (aContainer from = aComponent).
	self assert: (aContainer to = aType).
	 
	stream := ReadWriteStream on: ''.
	aContainer printOn: stream.
	
	self assert: (stream contents = (aContainer from mooseName , ' -> ' , aContainer to mooseName , ' (BAContainment)')).
]
