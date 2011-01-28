Class {
	#name : #MJEJBeanElement,
	#superclass : #XMLElement,
	#category : #'Moose-JEE-EJBDraftObjs'
}

{ #category : #accessing }
MJEJBeanElement >> createBeanFrom: aMooseModel [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MJEJBeanElement >> ejbName [

	^(self elements detect: [:each | each name = 'ejb-name']) strings first.
]

{ #category : #accessing }
MJEJBeanElement >> homeInterfaceFrom: aMooseModel [

	^self elements detect: [:x | x name = 'home']
			ifOne: [:x | aMooseModel allClasses entityNamed: ((x strings first copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #accessing }
MJEJBeanElement >> implementationClassFrom: aMooseModel [

	^self elements detect: [:x | x name = 'ejb-class'] 
			ifOne: [:x | aMooseModel allClasses entityNamed: ((x strings first copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #converting }
MJEJBeanElement >> populate: aMooseModel [
	
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
MJEJBeanElement >> remoteInterfaceFrom: aMooseModel [

	^self elements detect: [:x | x name = 'remote'] 
			ifOne: [:x | aMooseModel allClasses entityNamed: ((x strings first copyReplaceAll: '.' with: '::') asSymbol)]
			ifNone: [nil]
]

{ #category : #converting }
MJEJBeanElement >> usingAnnotationsPopulate: aMooseModel [ 
	
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
