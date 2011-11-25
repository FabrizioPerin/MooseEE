Class {
	#name : #MooseModelMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #tests }
MooseModelMJExtensionTests >> testAllDataLayer [
	| mooseModel dataLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	dataLayer := MJFAMIXDataLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
		
	self assert: (mooseModel allDataLayer size = 1).
	self assert: (mooseModel allDataLayer first  = dataLayer).
	
	self assert: dataLayer containedClasses size = 2.
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAllLayers [
	| mooseModel dataLayer allLayers strategy |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryComplex.
	
	(MJDefautLayeringStrategy on: mooseModel) instanciateLayers.
		
	self assert: (mooseModel allLayers size = 4).
	
	self assert: (mooseModel allPresentationLayer size = 1).
	self assert: (mooseModel allServiceLayer size = 1).
	self assert: (mooseModel allLogicLayer size = 1).
	self assert: (mooseModel allDataLayer size = 1).
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAllLogicLayer [

	| mooseModel logicLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	logicLayer := MJFAMIXLogicLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: (mooseModel allLogicLayer size = 1).
	self assert: (mooseModel allLogicLayer first  = logicLayer).
	self assert: logicLayer containedClasses size = 0.
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAllPresentitonLayer [

	| mooseModel presentationLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	presentationLayer := MJFAMIXPresentationLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: (mooseModel allPresentationLayer size = 1).
	self assert: (mooseModel allPresentationLayer first = presentationLayer).
	self assert: presentationLayer containedClasses size = 0.
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAllServiceLayer [

	| mooseModel serviceLayer |

	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryAndBeansAndHierarchi.

	serviceLayer := MJFAMIXServiceLayer new acceptStrategy: (MJDefautLayeringStrategy on: mooseModel).
	
	self assert: (mooseModel allServiceLayer size = 1).
	self assert: (mooseModel allServiceLayer first = serviceLayer).
	self assert: serviceLayer containedSessionBeans size = 3.
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAllTransactionalMethods [

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
	
	self assert: (mooseModel allTransactionalMethods size = 3).
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAnnotationTypeAndInstancesofTransactionScope [

	| mooseModel annotationTp allInstances annotatedMethods annotatedClasses |
	
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	mooseModel annotateTheModelForJEEBrowser.
	
	annotationTp := mooseModel allAnnotationTypes select: [:annotationType | annotationType name = #transactionScope ].
	
	self assert: ( annotationTp size = 1 ).
	
	allInstances := annotationTp first annotatedEntities.
	
	annotatedMethods := allInstances select: [ :each | each isKindOf: FAMIXMethod ].
	annotatedClasses := allInstances select: [ :each | each isKindOf: FAMIXClass ].	
	
	self assert: ( annotatedClasses size = 5 ).
	self assert: ( annotatedMethods size = 13 ). 
		
	
"	MooseBrowsers new codeWithAnnotationsBrowser openOn: mooseModel."
]

{ #category : #tests }
MooseModelMJExtensionTests >> testAnnotationTypeAndInstancesofUnsafeQuery [

	| mooseModel annotationTp allInstances annotatedMethods annotatedClasses |
	
	mooseModel := JEETestModels new sampleMooseModelWithTransAndQueryWithJavaAndFakeTransaction.

	mooseModel annotateTheModelForJEEBrowser.
	
	annotationTp := mooseModel allAnnotationTypes select: [:annotationType | annotationType name = #unsafeQuery ].
	
	self assert: ( annotationTp size = 1 ).
	
	allInstances := annotationTp first annotatedEntities.
	
	self assert: ( ( allInstances select: [ :each | each isKindOf: FAMIXMethod ] ) size = 5 ).
	self assert: ( ( allInstances select: [ :each | each isKindOf: FAMIXClass ] ) size = 2 ). 
	
	"mooseModel openInMoose."
	
	"MooseBrowsers new codeWithAnnotationsBrowser openOn: mooseModel."
]

{ #category : #tests }
MooseModelMJExtensionTests >> testCleanUpAllMaps [

	| jEETestModel mooseModel root annotationType famixAnchor distances result mapping table class |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithTransAndInvocationsAndDBAndQueryComplex.
	
	self assert: (mooseModel allMaps size = 0).

	"adding fake mappings"
	table := (mooseModel allTables select: [:each | each name = #Table1]) first.
	class := (mooseModel allClasses select: [:each | each name = #AStatelessSessionBean]) first.
	mapping := FAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel silentlyAdd: mapping.
	
	table := (mooseModel allTables select: [:each | each name = #Table2]) first.
	class := (mooseModel allClasses select: [:each | each name = #Class4]) first.
	mapping := FAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel silentlyAdd: mapping.
						
	self assert: (mooseModel allMaps size = 2).

	mooseModel cleanUpAllMaps.

 	self assert: (mooseModel allMaps size = 0). 
	
	
]

{ #category : #tests }
MooseModelMJExtensionTests >> testImplementationClassAfterThePopulation [
	| model entityBeansAnnotations |
	MooseModel resetMeta.
	model := MooseModel new.
	model importFromMSEStream: '(
		(FAMIX.Namespace (id: 100) (name ''aNamespace''))				
		(FAMIX.Class (id: 1) (name ''AClass''))
		(FAMIX.Class (id: 10) (name ''AnotherClass''))
		(FAMIX.Class (id: 11) (name ''StillAnotherClass''))
		(FAMIX.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(FAMIX.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 4) (name ''Entity'') (container (ref: 100)))
		(FAMIX.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 6) (name ''Stateful'') (container (ref: 100)))
		(FAMIX.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 9) (annotatedEntity (ref: 11)) (annotationType (ref: 6)))
	)' readStream.
	
	model instanciateJBeansFromAnnotations.
	
	self assert: (model allEntityBeans size = 2).
	self assert: (model allSessionBeans size = 1).
	
	self assert: (model allJEEBeans select: [:bean | bean implementationClass isNil ] ) size = 0.
	self assert: (model allSessionBeans anySatisfy: [:bean | bean implementationClass = (model allClasses select: [:each | each mooseName = #StillAnotherClass]) first ])

]

{ #category : #tests }
MooseModelMJExtensionTests >> testInstanciateAllBeansFromAnnotations [
	| model entityBeansAnnotations |
	MooseModel resetMeta.
	model := MooseModel new.
	model importFromMSEStream: '(
		(FAMIX.Namespace (id: 100) (name ''aNamespace''))				
		(FAMIX.Class (id: 1) (name ''AClass''))
		(FAMIX.Class (id: 10) (name ''AnotherClass''))
		(FAMIX.Class (id: 11) (name ''StillAnotherClass''))
		(FAMIX.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(FAMIX.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 4) (name ''Entity'') (container (ref: 100)))
		(FAMIX.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 6) (name ''Stateless'') (container (ref: 100)))
		(FAMIX.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 9) (annotatedEntity (ref: 11)) (annotationType (ref: 6)))
	)' readStream.
	
	model instanciateJBeansFromAnnotations.
	
	self assert: (model allEntityBeans size = 2).
	self assert: (model allSessionBeans size = 1).

	self assert: ((model allClasses entityNamed:#AClass) parentEJBBean mooseID = (model allEntityBeans select: [:entityBean | entityBean mooseID = (model allClasses entityNamed:#AClass) parentEJBBean mooseID]) first mooseID ).
	"self assert: ((model allClasses entityNamed:#AnotherClass) parentEJBBean = (model allEntityBeans entityNamed: 'Entity')  )."
	self assert: ((model allClasses entityNamed:#StillAnotherClass) parentEJBBean mooseID = (model allSessionBeans select: [:sessionBean | sessionBean mooseID = (model allClasses entityNamed:#StillAnotherClass) parentEJBBean mooseID]) first mooseID ).
	
]

{ #category : #tests }
MooseModelMJExtensionTests >> testInstanciateEntityBeansFromAnnotations [
	| model entityBeansAnnotations |
	MooseModel resetMeta.
	model := MooseModel new.
	model importFromMSEStream: '(
		(FAMIX.Namespace (id: 100) (name ''aNamespace''))				
		(FAMIX.Class (id: 1) (name ''AClass''))
		(FAMIX.Class (id: 10) (name ''AnotherClass''))
		(FAMIX.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(FAMIX.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 4) (name ''Entity'') (container (ref: 100)))
		(FAMIX.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 6) (name ''Session'') (container (ref: 100)))
		(FAMIX.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 9) (annotatedEntity (ref: 2)) (annotationType (ref: 6)))
	)' readStream.
	
	model instanciateJBeansFromAnnotations.
	
	self assert: (model allEntityBeans size = 2).
	self assert: ((model allEntityBeans detect: [:each | each mooseID = ((model allClasses entityNamed:#AClass) parentEJBBean mooseID) ] ) isKindOf: MJFAMIXEntityBean).

	
]

{ #category : #tests }
MooseModelMJExtensionTests >> testInstanciateJBeansFromAnnotations [
	| model entityBeansAnnotations |
	MooseModel resetMeta.
	model := MooseModel new.
	model importFromMSEStream: '(
		(FAMIX.Namespace (id: 100) (name ''aNamespace''))				
		(FAMIX.Class (id: 1) (name ''AClass''))
		(FAMIX.Class (id: 10) (name ''AnotherClass''))
		(FAMIX.Class (id: 11) (name ''StillAnotherClass''))
		(FAMIX.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(FAMIX.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 4) (name ''Entity'') (container (ref: 100)))
		(FAMIX.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 6) (name ''Stateful'') (container (ref: 100)))
		(FAMIX.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 9) (annotatedEntity (ref: 11)) (annotationType (ref: 6)))
	)' readStream.
	
	model instanciateJBeansFromAnnotations.
	
	self assert: (model allEntityBeans size = 2).
	self assert: (model allSessionBeans size = 1).
	
	self assert: (model allJEEBeans select: [:bean | bean implementationClass isNil ] ) size = 0.
	self assert: (model allSessionBeans anySatisfy: [:bean | bean implementationClass = (model allClasses select: [:each | each mooseName = #StillAnotherClass]) first ])

]

{ #category : #tests }
MooseModelMJExtensionTests >> testInstanciateSessionBeansFromAnnotations [
	| model entityBeansAnnotations |
	MooseModel resetMeta.
	model := MooseModel new.
	model importFromMSEStream: '(
		(FAMIX.Namespace (id: 100) (name ''aNamespace''))				
		(FAMIX.Class (id: 1) (name ''AClass''))
		(FAMIX.Class (id: 10) (name ''AnotherClass''))
		(FAMIX.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(FAMIX.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 4) (name ''Stateless'') (container (ref: 100)))
		(FAMIX.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(FAMIX.AnnotationType (id: 6) (name ''Stateful'') (container (ref: 100)))
		(FAMIX.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(FAMIX.AnnotationInstance (id: 9) (annotatedEntity (ref: 2)) (annotationType (ref: 6)))
	)' readStream.
	
	model instanciateJBeansFromAnnotations.
	
	self assert: (model allSessionBeans size = 3).
	self assert: ((model allSessionBeans detect: [:each | 
			each mooseID = ((model allClasses entityNamed:#AClass) parentEJBBean mooseID) ] ) isKindOf: MJFAMIXSessionBean).

	
]

{ #category : #tests }
MooseModelMJExtensionTests >> testInvocations [

	| mooseModel  invocation |
	mooseModel := JEETestModels new sampleMooseModelWithTransaction.
	invocation := mooseModel allInvocations.
	
	self assert: ( invocation isKindOf: MooseGroup ).
	self assert: ( invocation size = 5 ).

	self assert: ( ( invocation at: 1 ) isKindOf: FAMIXInvocation ).
	self assert: ( ( ( invocation at: 1 ) sender ) isKindOf: FAMIXMethod ).
	self assert: ( ( ( invocation at: 1 ) candidates ) isKindOf: Collection ).
	self assert: ( ( ( invocation at: 1 ) candidates ) size = 1 ).
	self assert: ( ( ( ( invocation at: 1 ) candidates ) at: 1 ) isKindOf: FAMIXMethod ).
	self assert: ( ( ( ( invocation at: 1 ) candidates ) at: 1 ) name = #someMethod ).
]

{ #category : #tests }
MooseModelMJExtensionTests >> testIsEJB21 [

	| mooseModel  invocation |
	mooseModel := JEETestModels new sampleMooseModel.
	
	self deny: mooseModel isEJB21.
	
	mooseModel ejbVersion: #EJB21.
	
	self assert: mooseModel isEJB21.  
]

{ #category : #tests }
MooseModelMJExtensionTests >> testIsEJB30 [

	| mooseModel  invocation |
	mooseModel := JEETestModels new sampleMooseModel.
	
	self deny: mooseModel isEJB30.
	
	mooseModel ejbVersion: #EJB30.
	
	self assert: mooseModel isEJB30.  
]
