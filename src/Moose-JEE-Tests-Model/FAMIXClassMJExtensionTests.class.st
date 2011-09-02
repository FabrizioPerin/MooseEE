Class {
	#name : #FAMIXClassMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
FAMIXClassMJExtensionTests >> testAccessATableSettingAutomaticallyConsideringTheMappings [
	| jEETestModel mooseModel root class table mapping |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	
	self deny: class accessATable.
	
	mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mooseModel add: mapping.
	
	self assert: (mooseModel allMaps size = 1).
	self assert: class accessATable.
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testAccessATableSettingItByHand [
	
	| class |
	
	class := FAMIXClass new name: 'TESTClass'.
	
	self assert: (class isMemberOf: FAMIXClass).
	self assert: (class name = 'TESTClass').
	
	class accessATable: true.
	
	self assert: class accessATable.
	
	class accessATable: false.
	
	self deny: class accessATable.
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testCompleteHierarchyInWhichThisResides [
	" I will fill MethodToAnalyze with all the methods that are part of a methods invokations chain that don't have a method that start a transaction"

	| allMethods interestingClasses mooseModel |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	allMethods :=  ( ( ( mooseModel allClasses ) flatCollect: [:each | each methods] ) select: #hasEJBTransactionAttribute ).
	allMethods := (( FAMIXMethodGroup new ) addAll: allMethods) deepCalledMethods.	


	"selecting just the classes that contained methods under analysis and the hierarchy that contain those classes."
	interestingClasses := OrderedCollection new addAll: ( ( mooseModel allClasses select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ) collect: [ :each | each completeHierarchyInWhichThisResides ] ) .
	
	self assert: (interestingClasses size = 4).
	
	interestingClasses := FAMIXClassGroup new addAll: ( ( (  mooseModel allClasses select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ) ) collect: [ :each | each completeHierarchyInWhichThisResides ] ).

	self assert: (interestingClasses size = 4).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testCompleteHierarchyInWhichThisResidesRight [
	| mooseModel |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeans.
	self assert: ( ( ( ( mooseModel allClasses select: [:each | each name = #'Class3' ] ) at: 1 ) completeHierarchyInWhichThisResides ) size = 2 ).
	self assert: ( ( ( ( mooseModel allClasses select: [:each | each name = #'Class6' ] ) at: 1 ) completeHierarchyInWhichThisResides ) size = 2 ).

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.
	self assert: ( ( ( ( mooseModel allClasses select: [:each | each name = #'Class3' ] ) at: 1 ) completeHierarchyInWhichThisResides ) size = 1 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testDTOsSampleTrace [
	
	| mooseModel |
	mooseModel := JEETestModels new mooseModelWithDTOs.

	mooseModel 
					
				
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testDoesImplements [
	
	| mooseModel |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.
	
	
	self assert: ( ( ( mooseModel allClasses select: [:each | each name = #Class3 ] ) at: 1 ) doesImplements: #Class6 ).
	self assert: ( ( ( mooseModel allClasses select: [:each | each name = #Class4 ] ) at: 1 ) doesImplements: #Class2 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testHasImplementsABean [

	| mooseModel allImplementingClasses |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeans.

	self assert: ( mooseModel allJEEBeans size = 8 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsABean ] ) size = 8 ).
	allImplementingClasses := mooseModel allClasses select: [:each | each hasImplementsABean ].
	self assert: ( ( mooseModel allJEEBeans select: [:bean | allImplementingClasses includes: bean implementationClass ] ) size = 8 ).


	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	
	self assert: ( mooseModel allJEEBeans size = 0 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsABean ] ) size = 0 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testHasImplementsAMessageDrivenBean [

	| mooseModel allImplementingClasses |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeans.
	
	self assert: ( mooseModel allMessageDrivenBeans size = 2 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsAMessageDrivenBean ] ) size = 2 ).
	allImplementingClasses := mooseModel allClasses select: [:each | each hasImplementsAMessageDrivenBean ].
	self assert: ( ( mooseModel allJEEBeans select: [:bean | allImplementingClasses includes: bean implementationClass ] ) size = 2 ).


	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	
	self assert: ( mooseModel allMessageDrivenBeans size = 0 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsAMessageDrivenBean ] ) size = 0 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testHasImplementsASessionBean [

	| mooseModel allImplementingClasses |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeans.
	
	self assert: ( mooseModel allSessionBeans size = 3 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsASessionBean ] ) size = 3 ).
	allImplementingClasses := mooseModel allClasses select: [:each | each hasImplementsASessionBean ].
	self assert: ( ( mooseModel allJEEBeans select: [:bean | allImplementingClasses includes: bean implementationClass ] ) size = 3 ).
	self assert: ( ( allImplementingClasses flatCollect: [ :each | each completeHierarchyInWhichThisResides]) size = 4 ).

	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	
	self assert: ( mooseModel allSessionBeans size = 0 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsASessionBean ] ) size = 0 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testHasImplementsAnEntityBean [

	| mooseModel allImplementingClasses |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeans.
	
	self assert: ( mooseModel allEntityBeans size = 3 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsAnEntityBean ] ) size = 3 ).
	allImplementingClasses := mooseModel allClasses select: [:each | each hasImplementsAnEntityBean ].
	self assert: ( ( mooseModel allJEEBeans select: [:bean | allImplementingClasses includes: bean implementationClass ] ) size = 3 ).


	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	
	self assert: ( mooseModel allEntityBeans size = 0 ).
	self assert: ( ( mooseModel allClasses select: [:each | each hasImplementsAnEntityBean ] ) size = 0 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testHasMethodsThatExecuteAQuery [
	| mooseModel classes |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.
	classes := mooseModel allClasses select: #hasMethodsThatExecuteAQuery.
	
	self assert: classes size = 1
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testImplementedEntityBean [

	| mooseModel allImplementingClasses classImplementingABean jEETestModel root |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithTransAndQueryAndBeans.
	"root := jEETestModel root.
	
	(root allElements  select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel]."
	
	self assert: ( mooseModel allEntityBeans size = 3 ).
	self assert: ( ( mooseModel allClasses select: #hasImplementsAnEntityBean ) size = 3 ).
	
	classImplementingABean := (mooseModel allClasses select: [:class | class name = #Class4]) first.
	
	self deny: (classImplementingABean implementedEntityBean isNil).
	self assert: (classImplementingABean implementedEntityBean isMemberOf: MJFAMIXEntityBean).
]

{ #category : #testsOnJEEModel }
FAMIXClassMJExtensionTests >> testIsADataLayerClass [

	| mooseModel |
	
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.
	
	self assert: ( mooseModel allClasses anySatisfy: [:each | each isADataLayerClass ] ).
 
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: ( mooseModel allClasses anySatisfy: [:each | each isADataLayerClass ] ).
]

{ #category : #'as yet unclassified' }
FAMIXClassMJExtensionTests >> testIsADataTransferClass [
	
	| mooseModel dtos |
	
	mooseModel := JEETestModels new mooseModelWithDTOs.
	
	dtos := mooseModel allClasses select: [:class | class isADataTransferClass].
	
	self assert: (dtos size = 3).
	self assert: (dtos anySatisfy: [:class | class name = #ClassDTO1] ).	
	self assert: (dtos anySatisfy: [:class | class name = #ClassDTO2] ).
	self assert: (dtos anySatisfy: [:class | class name = #DataTranferObject3] )
]

{ #category : #testsOnJEEModel }
FAMIXClassMJExtensionTests >> testIsADomainLayerClass [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: ( mooseModel allClasses anySatisfy: [:each | each isADomainLayerClass ] ).
]

{ #category : #testsOnJEEModel }
FAMIXClassMJExtensionTests >> testIsAPresentationLayerClass [

	| mooseModel  |
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self deny: ( mooseModel allClasses anySatisfy: [ :each | each isAPresentationLayerClass ] ).
]

{ #category : #'as yet unclassified' }
FAMIXClassMJExtensionTests >> testIsTestClass [
	
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

{ #category : #tests }
FAMIXClassMJExtensionTests >> testNOQM [

	| mooseModel  sum |
	sum := 0.
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.
	
	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #NOQM ) = 3).
	
	mooseModel allClasses do: [:each | sum := sum + each numberOfQueryingMethods ].
	self assert: ( sum = 3 ).
	
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testNOTM [

	| mooseModel  sum |
	sum := 0.
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	self assert: ( ( mooseModel allClasses sumOfPropertyNamed: #NOTM ) = 13).

	mooseModel allClasses do: [:each | sum := sum + each numberOfTransactionMethods ].
	self assert: ( sum = 13 ).
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testWithDeepInvokedClasses [

		| mooseModel class |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: (mooseModel allClasses size = 17).
	
	
	class := (mooseModel allClasses select: [:each | each name = #AStatefulSessionBean]) first.
	self assert: (class withDeepInvokedClasses) size = 1.
	
	class := (mooseModel allClasses select: [:each | each name = #AStatelessSessionBean]) first.
	self assert: (class withDeepInvokedClasses) size = 2.
	
	class := (mooseModel allClasses select: [:each | each name = #Class4]) first.
	self assert: (class withDeepInvokedClasses) size = 4.
]

{ #category : #tests }
FAMIXClassMJExtensionTests >> testWithDeepInvokingClasses [

	| mooseModel class |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.

	self assert: (mooseModel allClasses size = 17).
	
	
	class := (mooseModel allClasses select: [:each | each name = #AStatefulSessionBean]) first.
	self assert: (class withDeepInvokingClasses) size = 4.
	
	class := (mooseModel allClasses select: [:each | each name = #AStatelessSessionBean]) first.
	self assert: (class withDeepInvokingClasses) size = 3.
	
	class := (mooseModel allClasses select: [:each | each name = #Class4]) first.
	self assert: (class withDeepInvokingClasses) size = 2.
	
	
	
	
]
