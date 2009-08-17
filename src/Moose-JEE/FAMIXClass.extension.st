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
FAMIXClass >> hasMethodsThatExecuteAQuery [

	self flag: #TODO test.
	^self methods anySatisfy: [ :method | method doesExecuteAQuery ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasUnsafeMethods [

	self flag: #TODO test.
	^self methods anySatisfy: [ :method | method isPartOfATransaction not ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> hasUnsafeMethodsThatExecuteAQuery [

	"s| allMethods |
	allMethods := ( self methods select: #doesExecuteAQuery ) deepCalleeMethodsWithoutTransactionPath.
	^(self methods intersection: allMethods) isEmpty not"
	self flag: #TODO test.
	^self methods anySatisfy: [ :method | method isPartOfAnUnsafeTransactionPath and: [ method doesExecuteAQuery ] ].
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> implementedInterfaces [
	"returns a collection with all superclasses of this class"

	^self directSuperclasses select: #isInterface.
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> internalInvocations [

	self flag: #TODO test.
	^ self outgoingInvocationsGroup select: [:each |
				each anyCandidate notNil and: [
					each anyCandidate belongsTo == self and: [
							each invokedBy ~= each anyCandidate]]]
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
FAMIXClass >> isARowDataGateway [

	| executeUpdate executeDelete executeInsert |

	self flag: #TODOAndOtherStuff.

	executeUpdate := false.
	executeDelete := false.
	executeInsert := false.
	
	"Have to be implemented the rules related to the attributes of the class information from sql nedeed"

	self methods do: [ :eachMethod | ( ( eachMethod doesCall: #executeUpdate ) and: [ ( '.*delete.*' asRegex matches: ( eachMethod name asString ) ) ifTrue: [ executeDelete := true ] ] ). "This implementation have to be improve ( checking inside the method or in the name if is present the keyword delete )" 
								   ( (eachMethod doesCall: #executeUpdate ) and: [ ( '.*insert.*' asRegex matches: ( eachMethod name asString ) ) ifTrue: [ executeInsert := true ] ] ). "This implementation have to be improve ( checking inside the method or in the name if is present the keyword insert )" 
								   ( eachMethod doesCall: #executeUpdate )  ifTrue: [ executeUpdate := true ].
								   
	].

	^( ( executeUpdate and: [ executeDelete ] ) and: [ executeInsert ] )
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> numberOfQueryingMethods [
	<MSEProperty: #NOQM type: #Number>
	<property: #NOQM	longName: 'Number of querying methods'
		description: 'The number of methods that execute a query'
	>
	^self lookUpPropertyNamed: #NOQM computedAs: [ ( self methods select: [:method | method doesExecuteAQuery ] ) size ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> numberOfTransactionMethods [
	<MSEProperty: #NOTM type: #Number>
	<property: #NOTM
		longName: 'Number of transaction methods'
		description: 'The number of methods involved in a transaction'
	>
	^self lookUpPropertyNamed: #NOTM computedAs: [ ( self methods select: [:method | method isPartOfATransaction ] ) size ]
]

{ #category : #'*Moose-JEE' }
FAMIXClass >> parentEJBBean [

	^self privateState attributeGet: #parentEJBBean default: [nil]

]

{ #category : #'*Moose-JEE' }
FAMIXClass >> parentEJBBean: aBean [

	^self privateState attributeSet: #parentEJBBean value: aBean
]
