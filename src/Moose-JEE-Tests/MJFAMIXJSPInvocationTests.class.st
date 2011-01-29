Class {
	#name : #MJFAMIXJSPInvocationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXJSPInvocationTests >> testFAMIXMappingCreation [
	
	| mooseModel class jEETestModel root jsPage jspInvocation invocation |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModel.
	root := jEETestModel root.
	
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
	class := mooseModel entityNamed: #'aPackage::AStatelessSessionBean'.
	jsPage := MJFAMIXJSPPage new name: 'JSPageTest'.
	mooseModel add: jsPage.
	
	jspInvocation := MJFAMIXJSPInvocation new invocationSource: jsPage; invocationTarget: class.
	
	class addIncomingJspInvocation: jspInvocation.
	jsPage addOutgoingJspInvocations: jspInvocation.
	
	mooseModel add: jspInvocation.
	
	self assert: (mooseModel allJSPInvocations size = 1).
	
	invocation := (mooseModel allJSPInvocations select: [:each | each from = jsPage and: [each to = class]]).
	self assert: invocation size = 1.

]
