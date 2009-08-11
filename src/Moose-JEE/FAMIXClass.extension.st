Extension { #name : #FAMIXClass }

{ #category : #'*Moose-JEE' }
FAMIXClass >> completeHierarchyInWhichThisResides [ 

	| collection |
	
	collection := ( self withSuperclassHierarchy reject: [ :each | each isStub or: [ each isInterface ] ] ).

	collection isEmpty ifFalse: [ ^ (collection union: ( collection last withSubclassHierarchy ) ) ].
	^OrderedCollection new.
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> doesImplements: aSymbol [
	^self implementedInterfaces anySatisfy: [:each | each name = aSymbol ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasImplementsABean [
	^ ( ( self mooseModel allJEEBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasImplementsAMessageDrivenBean [
	^ ( ( self mooseModel allMessageDrivenBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasImplementsASessionBean [
	^ self mooseModel allSessionBeans anySatisfy: [:bean | bean implementationClass == self ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasImplementsAnEntityBean [
	^ ( ( self mooseModel allEntityBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> implementedInterfaces [
	"returns a collection with all superclasses of this class"

	^self directSuperclasses select: #isInterface.
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> isADataLayerClass [

	^ ( self methods anySatisfy: [ :eachMethod | eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ) or: [ self doesImplements: #Serializable ].
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> isADomainLayerClass [

	^ self methods anySatisfy: [ :eachMethod | eachMethod isADomainLayerMethod and: [ eachMethod isConstructor not ] ].
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> isAPresentationLayerClass [
	"This method check if a class i part of presentation layer considering:	
		- the class is a servlet?
		TO DO - the class has methods that uses methods of third part package to create graphical object
		- the class implement a session bean
		- the class have methods belongs to the presentation layer"

	self methods do: [ :eachMethod | ( eachMethod isAPresentationLayerMethod and: [ eachMethod isConstructor not ] ) ifTrue: [ ^true ] ].
	self directSuperclasses do: [ :each | 
		each name = '*HttpServlet*' ifTrue: [ ^true ] ].
	^ self hasImplementsASessionBean.
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> numberOfQueryingMethods [
	<property: #NOQM
		longName: 'Number of querying methods'
		description: 'The number of methods that execute a query'
	>
	^self lookUpPropertyNamed: #NOQM computedAs: [ ( self methods select: [:method | method doesExecuteAQuery ] ) size ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> numberOfTransactionMethods [
	<property: #NOTM
		longName: 'Number of transaction methods'
		description: 'The number of methods involved in a transaction'
	>
	^self lookUpPropertyNamed: #NOTM computedAs: [ ( self methods select: [:method | method isPartOfATransaction ] ) size ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> parentEJBBean: aBean [

	^self privateState attributeSet: #parentEJBBean value: aBean
]
