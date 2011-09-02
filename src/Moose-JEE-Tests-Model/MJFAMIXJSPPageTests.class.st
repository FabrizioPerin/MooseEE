Class {
	#name : #MJFAMIXJSPPageTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXJSPPageTests >> testAnnotation [
	self assert: MJFAMIXJSPAttribute annotation == MJFAMIXJSPAttribute.
]

{ #category : #tests }
MJFAMIXJSPPageTests >> testFiledIn [
	| jsPage |
	
	jsPage := MJFAMIXJSPPage new name: 'JSPageTest'.
	
	jsPage filedIn: 'fakeFileName.js'.
	
	self assert: (jsPage filedIn = 'fakeFileName.js').
]

{ #category : #tests }
MJFAMIXJSPPageTests >> testOutgoingJSPInvocations [
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
	
	self assert: (jsPage outgoingJspInvocations size = 1).
	self assert: (jsPage outgoingJspInvocations first = jspInvocation).

]
