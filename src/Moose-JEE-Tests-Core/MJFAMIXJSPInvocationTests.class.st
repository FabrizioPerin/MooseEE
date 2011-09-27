Class {
	#name : #MJFAMIXJSPInvocationTests,
	#superclass : #MJAssociationTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
MJFAMIXJSPInvocationTests >> testAnnotation [
	self assert: MJFAMIXJSPInvocation annotation == MJFAMIXJSPInvocation.
]

{ #category : #'as yet unclassified' }
MJFAMIXJSPInvocationTests >> testFAMIXJSPInvocationCreation [
	
	| mooseModel class jEETestModel jsPage jspInvocation invocation |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModel.

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

{ #category : #testsOnJEEModel }
MJFAMIXJSPInvocationTests >> testPrintOn [
	| mooseModel class jEETestModel jsPage jspInvocation invocation stream |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModel.

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

	
	stream := ReadWriteStream on: ''.
	invocation first printOn: stream.
	
	self assert: (stream contents = (invocation first invocationSource name asString , ' -> ' , invocation first invocationTarget name asString , ' (Invokes)')).
]
