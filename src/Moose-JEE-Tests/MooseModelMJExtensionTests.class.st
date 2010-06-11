Class {
	#name : #MooseModelMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

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
