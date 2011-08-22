Class {
	#name : #FAMIXMethodMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testAllMethodsTouchFromHereTo [

	| mooseModel  methods methodsTouched aMethod method11 |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.
	methods := mooseModel allMethods.

	aMethod := ( methods detect: [ :method | method name = #aMethod ] ).
	method11 := ( methods detect: [ :method | method name = #method11 ] ).

	self assert: ( methods isKindOf: FAMIXMethodGroup ).
	self assert: ( methods size = 19 ).
	
	methodsTouched := method11 allMethodsTouchFromHereTo: aMethod.
	
	self assert: ( methodsTouched size = 5 ).
	self assert: ( methodsTouched includes: ( methods detect: [ :method | method name = #method1 ] ) ).
	self assert: ( methodsTouched includes: ( methods detect: [ :method | method name = #method6 ] ) ).
	self assert: ( methodsTouched includes: ( methods detect: [ :method | method name = #method2 ] ) ).
	self assert: ( methodsTouched includes: aMethod ).
	self assert: ( methodsTouched includes: method11 ).

]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testDoesDeclare [
	| mooseModel jeeTestsModels class2 complexClass methodsDeclaringSomething |

	mooseModel := MooseModel new.
	jeeTestsModels := JEETestModels new.
	
	mooseModel addAll: jeeTestsModels class1 methods.
	mooseModel add: jeeTestsModels class1.
	
	class2 := jeeTestsModels class2.
	mooseModel addAll: class2 methods.
	mooseModel add: class2.
	
	complexClass := jeeTestsModels classWithComplexMethods.
	mooseModel addAll: complexClass methods.
	mooseModel addAll: (complexClass methods flatCollect: [:met | met localVariables ]).
	mooseModel addAll: (complexClass methods flatCollect: [:met | met parameters ]).
	mooseModel add: complexClass.
	
	self assert: (mooseModel allClasses size = 3).
	
	methodsDeclaringSomething := mooseModel allMethods select: [:m | m doesDeclare: #String].
	
	self assert: (methodsDeclaringSomething size = 2).
	self assert: (methodsDeclaringSomething first name = #method14).
	self assert: (methodsDeclaringSomething second name = #method15).	
	
	methodsDeclaringSomething := mooseModel allMethods select: [:m | m doesDeclare: complexClass name].
	
	self assert: (methodsDeclaringSomething size = 1).
	self assert: (methodsDeclaringSomething first name = #method14).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testDoesInvoke [

	| mooseModel  methods |
	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	methods := mooseModel allMethods.

	self assert: ( methods isKindOf: FAMIXMethodGroup ).
	self assert: ( methods size = 8 ).
	
	self assert: ( ( methods detect: [ :method | method name = #aMethod ] ) doesInvoke: #someMethod ).
	self assert: ( ( methods detect: [ :method | method name = #method2 ] ) doesInvoke: #aMethod ).
	self assert: ( ( methods detect: [ :method | method name = #method1 ] ) doesInvoke: #aMethod ).
	self assert: ( ( methods detect: [ :method | method name = #method3 ] ) doesInvoke: #method1 ).
	self assert: ( ( methods detect: [ :method | method name = #method4 ] ) doesInvoke: #method2 ).
]

{ #category : #testsOnJEEModel }
FAMIXMethodMJExtensionTests >> testDoesInvokesMethodsBelongJavaSqlPackage [
	
	| mooseModel methodsCollection |
	
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	methodsCollection := ( mooseModel allMethods select: [:method | method doesInvokesMethodsBelongJavaSqlPackage ] ).
	
	self assert: methodsCollection size = 3.
	self assert: (methodsCollection anySatisfy: [:each | each name = #method1]).
	self assert: (methodsCollection anySatisfy: [:each | each name = #method2]).
	self assert: (methodsCollection anySatisfy: [:each | each name = #method3]).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testDoesReturn [
	| mooseModel jeeTestsModels class2 complexClass methodsReturningSomething |
	
	mooseModel := MooseModel new.
	jeeTestsModels := JEETestModels new.
	
	mooseModel addAll: jeeTestsModels class1 methods.
	mooseModel add: jeeTestsModels class1.
	
	class2 := jeeTestsModels class2.
	mooseModel addAll: class2 methods.
	mooseModel add: class2.
	
	complexClass := jeeTestsModels classWithComplexMethods.
	mooseModel addAll: complexClass methods.
	mooseModel addAll: (complexClass methods flatCollect: [:met | met localVariables ]).
	mooseModel addAll: (complexClass methods flatCollect: [:met | met parameters ]).
	mooseModel add: complexClass.
	
	self assert: (mooseModel allClasses size = 3).
	
	methodsReturningSomething := mooseModel allMethods select: [:m | m doesReturn: #String].
	
	self assert: (methodsReturningSomething size = 1).
	self assert: (methodsReturningSomething first name = #method12).
	
	methodsReturningSomething := mooseModel allMethods select: [:m | m doesReturn: complexClass name asSymbol].
	
	self assert: (methodsReturningSomething size = 1).
	self assert: (methodsReturningSomething first name = #method11).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testExecuteAQuery [

	| mooseModel  methods temp |
	" mooseModel := self sampleMooseModel3. "
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQuery.
	
	methods := mooseModel allMethods.

	self assert: ( methods isKindOf: FAMIXMethodGroup ).
	self assert: ( methods size = 9 ).

	self deny: (methods detect: [ :method | method name = #aMethod]) doesExecuteAQuery.
	self deny: ( methods detect: [:method | method name = #anotherMethod] ) doesExecuteAQuery.

	self assert: (methods detect: [ :method | method name = #someMethod ] ) doesExecuteAQuery.

	self deny:  (methods detect: [ :method | method name = #someOtherMethod ] ) doesExecuteAQuery.

	methods do: [ :method | method name = #method1 ifTrue: [ temp := ( method doesExecuteAQuery ) ] ].
	self deny: ( temp ).
	methods do: [ :method | method name = #method2 ifTrue: [ temp := ( method doesExecuteAQuery ) ] ].
	self deny: ( temp ).
	methods do: [ :method | method name = #method3 ifTrue: [ temp := ( method doesExecuteAQuery ) ] ].
	self deny: ( temp ).
	methods do: [ :method | method name = #method4 ifTrue: [ temp := ( method doesExecuteAQuery ) ] ].
	self deny: ( temp ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testFAMIXMethodDeepCalledMethods [
	

	| mooseModel  allMethods methods |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	allMethods := ( mooseModel allMethods select: #hasEJBTransactionAttribute ) deepCalledMethods.
	methods := OrderedCollection withAll: ( mooseModel allMethods select: #hasEJBTransactionAttribute ).
	methods := methods flatCollect: [:each | each deepCalledMethods ].

	self assert: ( methods isKindOf: OrderedCollection ).
	self assert: ( methods size = 23 ).
	self assert: ( methods asSet asOrderedCollection size = 13 ).
	self assert: (allMethods isKindOf: OrderedCollection ).
	self assert: (allMethods size = 13 ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testFAMIXMethodDeepCalleeMethods [

	| mooseModel  allMethods methods |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	allMethods := ( mooseModel allMethods select: #doesExecuteAQuery ) deepCalleeMethods.
	methods := OrderedCollection withAll: ( mooseModel allMethods select: #doesExecuteAQuery ).
	methods := methods flatCollect: [:each | each deepCalleeMethods ].

	self assert: (allMethods size = 14 ).
	self assert: (methods size = 15 ).
	self assert: (methods asSet size = 14 ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testFAMIXMethodDeepCalleeMethodsWithoutTransactionPath [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: ( ( mooseModel allMethods select: [:each | each name = #executeBatch ] ) first deepCalleeMethodsWithoutTransactionPath ) size = 7.
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testHasAParameterOf [
	| mooseModel jeeTestsModels class2 complexClass methodsWithParameters |

	mooseModel := MooseModel new.
	jeeTestsModels := JEETestModels new.
	
	mooseModel addAll: jeeTestsModels class1 methods.
	mooseModel add: jeeTestsModels class1.
	
	class2 := jeeTestsModels class2.
	mooseModel addAll: class2 methods.
	mooseModel add: class2.
	
	complexClass := jeeTestsModels classWithComplexMethods.
	mooseModel addAll: complexClass methods.
	mooseModel addAll: (complexClass methods flatCollect: [:met | met localVariables ]).
	mooseModel addAll: (complexClass methods flatCollect: [:met | met parameters ]).
	mooseModel add: complexClass.
	
	self assert: (mooseModel allClasses size = 3).
	
	methodsWithParameters := mooseModel allMethods select: [:m | m hasAParameterOf: #String].
	
	self assert: (methodsWithParameters size = 2).
	self assert: (methodsWithParameters first name = #method12).
	self assert: (methodsWithParameters second name = #method13).	
	
	methodsWithParameters := mooseModel allMethods select: [:m | m hasAParameterOf: complexClass name].
	
	self assert: (methodsWithParameters size = 1).
	self assert: (methodsWithParameters first name = #method12).	
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testHasEJBTransactionAttribute [
	| mooseModel  jEETestModel root |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.
	
	(root allElements select: [:each | each class = MJSessionElement]) do: [:each |
		each populate: mooseModel].
	(root allElements select: [:each | each class = MJContainerTransactionElement]) do: [:each |
		each populate: mooseModel].

	self assert: (mooseModel allMethods entityNamed: #'aPackage::AStatelessSessionBean.aMethod()')
					hasEJBTransactionAttribute.
	self assert: (mooseModel allMethods entityNamed: #'aPackage::AStatelessSessionBean.anotherMethod()')
					hasEJBTransactionAttribute not.

	self assert: ((mooseModel allClasses entityNamed: #'aPackage::AStatefulSessionBean')
					methods allSatisfy: #hasEJBTransactionAttribute).
	self assert: (mooseModel allClasses entityNamed: #'aPackage::AStatefulSessionBean')
					methods size = 2
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testHasEJBTransactionAttributeThatSupportTransactions [
	| mooseModel  jEETestModel root |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel setRootFrom: jEETestModel minimalEjbJarWithSupportedTransactions.
	
	(root allElements select: [:each | each class = MJSessionElement]) do: [:each |
		each populate: mooseModel].
	(root allElements select: [:each | each class = MJContainerTransactionElement]) do: [:each |
		each populate: mooseModel].

	
	self assert: (mooseModel allClasses entityNamed: #'aPackage::AStatelessSessionBean')
					methods size = 2.
	self assert: (mooseModel allMethods entityNamed: #'aPackage::AStatelessSessionBean.aMethod()')
					hasEJBTransactionAttributeThatSupportTransactions.
	self deny: (mooseModel allMethods entityNamed: #'aPackage::AStatelessSessionBean.anotherMethod()')
					hasEJBTransactionAttributeThatSupportTransactions.
		
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testInvocationCallChain [
	
	| mooseModel  invocation |
	mooseModel := JEETestModels new sampleMooseModelWithInvocation.
	mooseModel allMethods do: [:each | each name = #aMethod ifTrue: [ invocation := each  deepCalledMethods ] ].
	
	self assert: ( invocation isKindOf: OrderedCollection ).
	self assert: ( invocation size = 2 ).
	self assert: ( ( invocation first ) isKindOf: FAMIXMethod ).
	self assert: ( ( invocation first ) name = #aMethod ).
	self assert: ( ( invocation second ) isKindOf: FAMIXMethod ).	
	self assert: ( ( invocation second ) name = #someMethod ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testInvocationCalleeChain [
	
	| mooseModel  invocation |
	mooseModel := JEETestModels new sampleMooseModelWithInvocation.

	mooseModel allMethods do: [:each | each name = #someMethod ifTrue: [ invocation := ( (FAMIXMethodGroup new add: each ) deepCalleeMethods )] ].
	
	self assert: ( invocation isKindOf: OrderedCollection ).
	self assert: ( invocation size = 2 ).
	self assert: ( ( invocation at: 1 ) isKindOf: FAMIXMethod ).
	self assert: ( ( invocation at: 1 ) name = #someMethod ).
	self assert: ( ( invocation at: 2 ) isKindOf: FAMIXMethod ).	
	self assert: ( ( invocation at: 2 ) name = #aMethod ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testIsPartOfATransaction [

	| mooseModel  methodGroup |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	methodGroup := mooseModel allMethods select: [ :each | each name = #method1 ].
	
	self assert: methodGroup first isPartOfATransaction.
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testIsPartOfATransactionVsDeepCalledMethods [

	| mooseModel  allMethods methods |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	allMethods := ( mooseModel allMethods select: #isPartOfATransaction ).
	methods := ( mooseModel allMethods select: #hasEJBTransactionAttribute ) deepCalledMethods.

	self assert: (methods isKindOf: OrderedCollection).
	self assert: ( methods size = allMethods size ).

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQuery.
	
	allMethods := ( mooseModel allMethods select: #isPartOfATransaction ).
	methods := ( mooseModel allMethods select: #hasEJBTransactionAttribute ) deepCalledMethods.

	self assert: (methods isKindOf: OrderedCollection).
	self assert: ( methods size = allMethods size ).

	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	
	allMethods := ( mooseModel allMethods select: #isPartOfATransaction ).
	methods := ( mooseModel allMethods select: #hasEJBTransactionAttribute ) deepCalledMethods.

	self assert: (methods isKindOf: OrderedCollection).
	self assert: ( methods size = allMethods size ).

	mooseModel := JEETestModels new sampleMooseModelWithInvocation.
	
	allMethods := ( mooseModel allMethods select: #isPartOfATransaction ).
	methods := ( mooseModel allMethods select: #hasEJBTransactionAttribute ).

	self assert: (allMethods size = 0).
	self assert: ( methods size = 0 ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testIsPartOfAnUnsafeTransactionPath [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: ( ( mooseModel allMethods select: [:each | each name = #method1 ] ) first isPartOfAnUnsafeTransactionPath ).
	self assert: ( ( mooseModel allMethods select: [:each | each name = #executeBatch ] ) first isPartOfAnUnsafeTransactionPath ).
	self assert: ( ( mooseModel allMethods select: [:each | each name = #method6 ] ) first isPartOfAnUnsafeTransactionPath ).
	self deny: ( ( mooseModel allMethods select: [:each | each name = #method3 ] ) first isPartOfAnUnsafeTransactionPath ).

	self assert: ( ( mooseModel allMethods select: [:each | each name = #method8 ] ) first isPartOfAnUnsafeTransactionPath ).
	self deny: ( ( mooseModel allMethods select: [:each | each name = #method9 ] ) first startATransaction ).
	self assert: ( ( mooseModel allMethods select: [:each | each name = #method9 ] ) first isPartOfAnUnsafeTransactionPath ).
	self assert: ( ( mooseModel allMethods select: [:each | each name = #method4 ] ) first isPartOfAnUnsafeTransactionPath ).
	self assert: ( ( mooseModel allMethods select: [:each | each name = #method4 ] ) first isPartOfATransaction ).
	"method 4 is called from method 8 and 9. the first start a transaction, the second does not"
	
	self assert: ( ( mooseModel allMethods select: [:each | each name = #someMethod ] ) first isPartOfAnUnsafeTransactionPath ).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testOwnedTable [
	| jEETestModel mooseModel root class table mapping |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.
	
	class := mooseModel entityNamed: #'aPackage::AStatelessSessionBean'.
	table := mooseModel entityNamed: #Table1.
	
	self assert: (class methods allSatisfy: [: method | method ownedTable = nil ]).
	
	class methods first ownedTable: table.
	
	self assert: (class methods first ownedTable = table).
]

{ #category : #tests }
FAMIXMethodMJExtensionTests >> testStartAUselessTransaction [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	self assert: ( mooseModel allMethods select: [:each | each startAUselessTransaction ] ) size = 2.
]
