Class {
	#name : #FAMIXMethodGroupMJExtensionTests,
	#superclass : #MJAbstractGroupTests,
	#category : #'Moose-JEE-Tests-Core'
}

{ #category : #tests }
FAMIXMethodGroupMJExtensionTests >> testDeepCalledMethods [
	" I will fill MethodToAnalyze with all the methods that are part of a methods invokations chain that don't have a method that start a transaction"

	| allMethods interestingClasses mooseModel |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	allMethods :=  ( ( ( mooseModel allClasses ) flatCollect: [:class | class methods ] ) select: #hasEJBTransactionAttribute ).
	allMethods := (( FAMIXMethodGroup new ) addAll: allMethods) deepCalledMethods.
	
	"selecting just the classes that contained methods under analysis and the hierarchy that contain those classes."
	interestingClasses := FAMIXClassGroup new addAll: ( ( (  mooseModel allClasses select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ) ) collect: [ :each | each completeHierarchyInWhichThisResides ] ).

	self assert: (interestingClasses size = 4).
]

{ #category : #tests }
FAMIXMethodGroupMJExtensionTests >> testDeepCalledMethods2 [
	
	| mooseModel  invocation MG |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	invocation := OrderedCollection new.
	
	MG := mooseModel allMethods select: #hasEJBTransactionAttribute.
	
	self assert: (MG isKindOf: FAMIXMethodGroup).
	
	invocation addAll: ( MG deepCalledMethods ). 
	
	self assert: ( invocation isKindOf: OrderedCollection ).
	self assert: ( invocation size = 13 ).
]

{ #category : #tests }
FAMIXMethodGroupMJExtensionTests >> testInvocationCalleeChainWhitoutTransactionPath [
	
	| mooseModel  invocation MG |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	invocation := OrderedCollection new.

	MG := mooseModel allMethods select: #doesExecuteAQuery.
	
	self assert: (MG isKindOf: FAMIXMethodGroup).

	invocation addAll: MG deepCalleeMethodsWithoutTransactionPath.

	self assert: ( invocation isKindOf: OrderedCollection ).
	self assert: (invocation size = 6 ).
]

{ #category : #tests }
FAMIXMethodGroupMJExtensionTests >> testInvocationCalleeChainWithMethodGroup [

	| mooseModel  invocation MG |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	MG := mooseModel allMethods select: #doesExecuteAQuery.

	self assert: (MG isKindOf: FAMIXMethodGroup).

	invocation := MG deepCalleeMethods.

	self assert: ( invocation isKindOf: OrderedCollection ).
	self assert: ( invocation size = 14 ).
]
