Class {
	#name : #EJBBeanElement,
	#superclass : #OPGenericElement,
	#category : #'Moose-JEE-Opax'
}

{ #category : #accessing }
EJBBeanElement >> createBeanFrom: aMooseModel [
	
	^self subclassResponsibility
]

{ #category : #accessing }
EJBBeanElement >> ejbName [

	^(self children detect: [:each | each tag = 'ejb-name']) characters.
]

{ #category : #accessing }
EJBBeanElement >> homeInterfaceFrom: aMooseModel [

	^self children detect: [:x | x tag = 'home']
			ifPresent: [:x | aMooseModel allClasses entityNamed: ((x characters copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #accessing }
EJBBeanElement >> implementationClassFrom: aMooseModel [

	^self children detect: [:x | x tag = 'ejb-class'] 
			ifPresent: [:x | aMooseModel allClasses entityNamed: ((x characters copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #converting }
EJBBeanElement >> populate: aMooseModel [
	
	| bean |
	bean := self createBeanFrom: aMooseModel.
	bean name: self ejbName.
	bean remoteInterface: (self remoteInterfaceFrom: aMooseModel).
	bean remoteInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean homeInterface: (self homeInterfaceFrom: aMooseModel).
	bean homeInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean implementationClass: (self implementationClassFrom: aMooseModel).
	bean implementationClass ifNotNil: [:cls | cls parentEJBBean: bean].
	aMooseModel add: bean.
	^bean
]

{ #category : #accessing }
EJBBeanElement >> remoteInterfaceFrom: aMooseModel [

	^self children detect: [:x | x tag = 'remote'] 
			ifPresent: [:x | aMooseModel allClasses entityNamed: ((x characters copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #converting }
EJBBeanElement >> usingAnnotationsPopulate: aMooseModel [ 
	
	| annotations entityBeansAnnotations messageDrivenBeansAnnotations sessionBeansAnnotations sessionBeans |
	
	entityBeansAnnotations := aMooseModel allAnnotationInstances entities select: [:each | each annotationType name = 'Entity'].
	messageDrivenBeansAnnotations := aMooseModel allAnnotationInstances entities select: [:each | each annotationType name = 'MessageDriven'].
	sessionBeansAnnotations := aMooseModel allAnnotationInstances entities select: [:each | each annotationType name = 'Session'].
	
	entityBeansAnnotations do: [:annotation | 
									| bean |
									"self haltOnce. "
									bean := MJFAMIXEntityBean new.
									aMooseModel allClasses detect: [:class | class name: (annotation annotatedEntities name).] 
									].
	
	"sessionBeansAnnotations do: [:annotation |  annotation ]."

	"bean := self createBeanFrom: aMooseModel.
	bean name: self ejbName.
	bean remoteInterface: (self remoteInterfaceFrom: aMooseModel).
	bean remoteInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean homeInterface: (self homeInterfaceFrom: aMooseModel).
	bean homeInterface ifNotNil: [:cls | cls parentEJBBean: bean].
	bean implementationClass: (self implementationClassFrom: aMooseModel).
	bean implementationClass ifNotNil: [:cls | cls parentEJBBean: bean].
	aMooseModel add: bean.
	^bean"
]
