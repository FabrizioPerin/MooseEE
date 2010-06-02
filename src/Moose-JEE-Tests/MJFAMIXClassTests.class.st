Class {
	#name : #MJFAMIXClassTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXClassTests >> testDTOs [
	
	| mooseModel  |
	mooseModel := JEETestModels new mooseModelWithDTOs.


					
				
]

{ #category : #'as yet unclassified' }
MJFAMIXClassTests >> testIsADataTransferClass [
	
	| mooseModel dtos |
	
	mooseModel := JEETestModels new mooseModelWithDTOs.
	
	dtos := mooseModel allClasses select: [:class | class isADataTransferClass].
	
	self assert: (dtos size = 3).
	self assert: (dtos anySatisfy: [:class | class name = #ClassDTO1] ).	
	self assert: (dtos anySatisfy: [:class | class name = #ClassDTO2] ).
	self assert: (dtos anySatisfy: [:class | class name = #DataTranferObject3] )
]

{ #category : #'as yet unclassified' }
MJFAMIXClassTests >> testIsTestClass [
	
	| mooseModel jeeTestsModels class2 testClasses tClass |
	
	mooseModel := MooseModel new.
	
	jeeTestsModels := JEETestModels new.
	
	mooseModel addAll: jeeTestsModels class1 methods.
	mooseModel add: jeeTestsModels class1.
	
	tClass := jeeTestsModels testClass.
	mooseModel addAll: tClass methods.
	mooseModel add: tClass.
	
	class2 := jeeTestsModels class2.
	class2 container: jeeTestsModels testNamespace.

	mooseModel addAll: class2 methods.
	mooseModel add: class2.
	mooseModel add: class2 container.
	
	testClasses := mooseModel allClasses select: [:class | class isTestClass].
	
	self assert: (mooseModel allClasses size = 3).
	self assert: (testClasses size = 2).
	self assert: (testClasses includes: class2 ).
	self assert: (testClasses includes: tClass ).
	 
]
