Extension { #name : #FAMIXClass }

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> accessATable [
	<MSEProperty: #accessATable type: #Boolean>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState 
		attributeAt: #accessATable 
		ifAbsent: [
			| val |
			val := self mappedRelationalEntities size > 0.
			"self accessATable: val."
			val.]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> accessATable: aBooleanOrNil [
	
	^self privateState attributeAt: #accessATable put: aBooleanOrNil
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> addIncomingJspInvocation: aJSPInvocation [
		
	^self incomingJspInvocation add: aJSPInvocation
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> completeHierarchyInWhichThisResides [ 

	| collection |
	
	collection := ( self withSuperclassHierarchy reject: [ :each | each isStub or: [ each isInterface ] ] ).

	collection isEmpty ifFalse: [ ^ (collection union: ( collection last withSubclassHierarchy ) ) ].
	^Set new.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> doesImplements: aSymbol [
	^self implementedInterfaces anySatisfy: [:each | each name = aSymbol ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasImplementsABean [
	^ ( ( self mooseModel allJEEBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasImplementsAMessageDrivenBean [
	^ ( ( self mooseModel allMessageDrivenBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasImplementsASessionBean [
	^ self mooseModel allSessionBeans anySatisfy: [:bean | bean implementationClass == self ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasImplementsAnEntityBean [
	^ ( ( self mooseModel allEntityBeans ) anySatisfy: [:bean | bean implementationClass == self ] )
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasMethodsThatExecuteAQuery [

	^self methods anySatisfy: [ :method | method doesExecuteAQuery ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasUnsafeMethods [

	self flag: #TODO test.
	^self methods anySatisfy: [ :method | method isPartOfATransaction not ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> hasUnsafeMethodsThatExecuteAQuery [

	"s| allMethods |
	allMethods := ( self methods select: #doesExecuteAQuery ) deepCalleeMethodsWithoutTransactionPath.
	^(self methods intersection: allMethods) isEmpty not"
	self flag: #TODO test.
	^self methods anySatisfy: [ :method | method isPartOfAnUnsafeTransactionPath and: [ method doesExecuteAQuery ] ].
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> implementedEntityBean [
	| bean |
	
	bean := ( ( self mooseModel allEntityBeans ) select: [:implementor | implementor implementationClass == self ] ).
	bean isEmpty 
		ifTrue: [^nil] 
		ifFalse: [^bean first].
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> implementedInterfaces [
	"returns a collection with all superclasses of this class"

	^self directSuperclasses select: #isInterface.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> incomingJspInvocation [
	<MSEProperty: #incomingJspInvocation type: #MJFAMIXJSPInvocation opposite: #invocationTarget> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeAt: #incomingJspInvocation ifAbsent: [FMMultivalueLink on: self opposite: #invocationTarget:].
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> incomingJspInvocation: aJSPInvocation [
		
	^self incomingJspInvocation value: aJSPInvocation
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> isADataLayerClass [

	^ ( self methods anySatisfy: [ :eachMethod | 
			eachMethod isADataLayerMethod and: [ eachMethod isConstructor not ] ] ) 
			or: [ (self doesImplements: #Serializable) "and: [ self propertyNamed: #DataClass ifNil: [true] ]" ].
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> isADataTransferClass [

	^ self isTestClass not 
		and: 
			[('.*DTO.*' asRegexIgnoringCase matches: self name) 
			or: [('.*VO.*' asRegexIgnoringCase matches: self name) 
			or: [self doesImplements: #Serializable] ] 
		]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> isADomainLayerClass [

	^ self methods anySatisfy: [ :eachMethod | eachMethod isADomainLayerMethod and: [ eachMethod isConstructor not ] ].
]

{ #category : #'*Moose-JEE-Core-Model' }
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

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> isARowDataGateway [

	| executeUpdate executeDelete executeInsert |

	self flag: #TODOAndOtherStuff.

	executeUpdate := false.
	executeDelete := false.
	executeInsert := false.
	
	"Have to be implemented the rules related to the attributes of the class information from sql nedeed"

	self methods do: [ :eachMethod | ( ( eachMethod doesInvoke: #executeUpdate ) and: [ ( '.*delete.*' asRegex matches: ( eachMethod name asString ) ) ifTrue: [ executeDelete := true ] ] ). "This implementation have to be improve ( checking inside the method or in the name if is present the keyword delete )" 
								   ( (eachMethod doesInvoke: #executeUpdate ) and: [ ( '.*insert.*' asRegex matches: ( eachMethod name asString ) ) ifTrue: [ executeInsert := true ] ] ). "This implementation have to be improve ( checking inside the method or in the name if is present the keyword insert )" 
								   ( eachMethod doesInvoke: #executeUpdate )  ifTrue: [ executeUpdate := true ].
								   
	].

	^( ( executeUpdate and: [ executeDelete ] ) and: [ executeInsert ] )
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> isTestClass [

	^( '.*Test.*' asRegex matches: self name) or: ['.*test.*' asRegex matches: self container name]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> numberOfQueryingMethods [
	<MSEProperty: #NOQM type: #Number>
	<property: #NOQM	longName: 'Number of querying methods'
		description: 'The number of methods that execute a query'
	>
	^self lookUpPropertyNamed: #NOQM computedAs: [ ( self methods select: [:method | method doesExecuteAQuery ] ) size ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> numberOfTransactionMethods [
	<MSEProperty: #NOTM type: #Number>
	<property: #NOTM
		longName: 'Number of transaction methods'
		description: 'The number of methods involved in a transaction'
	>
	^self lookUpPropertyNamed: #NOTM computedAs: [ ( self methods select: [:method | method isPartOfATransaction ] ) size ]
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> pageRankValue [
	<property: #PRV longName: 'Page Rank Value' description:
			'The value assigned by the page rank algorithm to this class considering the client classes'>
			
	^self
		lookUpPropertyNamed: #PRV
		computedAs: [
				| assoc |
				assoc := ((PageRank new 
						referenced: #clientClasses;
						runOn: (self mooseModel allClasses reject: [:each | each isTestClass])) collect: [:each | each = self]) first.
				(assoc value integerPart asString , '.' , assoc value fractionPart asString asString sliceFrom: 1 to: 3)]
		
	
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> parentEJBBean [
	<MSEProperty: #parentEJBBean type: #Object>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState attributeAt: #parentEJBBean ifAbsent: [nil]

]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> parentEJBBean: aBean [

	^self privateState attributeAt: #parentEJBBean put: aBean
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> viewMethodsHighlightingTransactionalOn: view [
		| allInterestingMethods otherMethods|

		allInterestingMethods := self methods select: #isPartOfATransaction.
		otherMethods := self methods difference: allInterestingMethods.

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color lightGray lighter ) borderColor: Color gray ).
		view nodes: otherMethods.


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( (MOEllipseShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( (MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor:  Color blue darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker darker).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color magenta ) borderColor: Color magenta darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color magenta ) borderColor: Color magenta darker darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).
	
	
		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view shape line color darker.
		view edges: self internalInvocations from: #sender toAll: #candidates.
		view horizontalDominanceTreeLayout.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> viewMethodsIncludeIn: aMethodList ForUnsafeQueriesOn: view [ 
	| usefulMethods |
	
	usefulMethods := self methods intersection: aMethodList.
	
	view nodeShape: ( (MOEllipseShape width: 7 height: 7 fillColor: Color yellow) borderColor:  Color yellow darker darker ).
	view nodes: ( usefulMethods select: [ :each | ( each doesInvoke: 'executeQuery' ) and: [ ( each doesInvoke: 'executeUpdate' ) not ] ] ).

	view nodeShape: ( (MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor:  Color orange darker darker ).
	view nodes: ( usefulMethods select: [ :each | ( each doesInvoke: 'executeQuery' ) not and: [ ( each doesInvoke: 'executeUpdate' )  ] ] ).
		
	view nodeShape: ( (MOEllipseShape width: 7 height: 7 fillColor: Color red) borderColor:  Color red darker darker ).
	view nodes: ( usefulMethods select: [ :each | ( each doesInvoke: 'executeQuery' ) and: [ each doesInvoke: 'executeUpdate' ] ] ).
		
	view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray).
	view nodes: ( usefulMethods select: [ :each | each doesExecuteAQuery not ] ).

	view shape line color darker.
	view edges: self internalInvocations from: #sender toAll: #candidates.
	view horizontalTreeLayout 
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> viewTransactionalMethodsOn: view [
		| allInterestingMethods |

		allInterestingMethods := self methods select: #isPartOfATransaction.

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( (MOEllipseShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( (MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor:  Color blue darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker darker).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).


		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color magenta ) borderColor: Color magenta darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color magenta ) borderColor: Color magenta darker darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).

		
		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).
	
	
		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view interaction item: 'inspect' action: [:elem | elem inspect ].
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view shape line color darker.
		view edges: self internalInvocations from: #sender toAll: #candidates.
		view horizontalDominanceTreeLayout.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> withDeepInvokedClasses [

	| cursor result invokedClassesAndTheirSubclasses |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		invokedClassesAndTheirSubclasses := (( result at: cursor ) invokedClasses reject: #isStub) flatCollect: [:each | each withSubclassHierarchy].
		result addAll: ( invokedClassesAndTheirSubclasses reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]

{ #category : #'*Moose-JEE-Core-Model' }
FAMIXClass >> withDeepInvokingClasses [

	| cursor result invokingClassesAndTheirSubclasses |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		invokingClassesAndTheirSubclasses := (( result at: cursor ) invokingClasses reject: #isStub) flatCollect: [:each | each withSubclassHierarchy].
		result addAll: ( invokingClassesAndTheirSubclasses reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]
