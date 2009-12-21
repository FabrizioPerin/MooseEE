Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOQMNOM [
	
	<property: #'R_NOQM_NOM'
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>
	^self lookUpPropertyNamed: #'R_NOQM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOTMNOM [
	<property: #'R_NOTM_NOM'
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>
	^self lookUpPropertyNamed: #'R_NOTM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlow [
	<menuItem: 'Methods With Transaction Flow' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewMethodsWithTransactionFlowOn: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowOn: view [
	"<menuItem: 'Transaction Flow 2' category: 'Visualize'>"

	| interestingClasses allInterestingMethods internalInvocations otherMethods |
	
	interestingClasses := self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ].
	
	view nodes: interestingClasses
		forEach:
			[ :eachClass | 
			allInterestingMethods := eachClass methods select: #isPartOfATransaction.
			otherMethods := eachClass methods difference: allInterestingMethods.
			
			view nodeShape: ( MOEllipseShape width: 7 height: 7 fillColor: Color white).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color white ) ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker ).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color red ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).
					
			view nodeShape: ((MOEllipseShape width: 7 height: 7 fillColor: Color cyan) borderColor: Color blue lighter).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint not
																		and: [ each hasEJBTransactionAttribute ] ] ] ] ).
									
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color cyan) borderColor: Color blue lighter).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery not
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint not
																		and: [ each hasEJBTransactionAttribute ] ] ] ] ).
									
									
			view nodeShape: ((MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery 																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint
																		and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).
							
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery not
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint
																		and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).
							
			view nodeShape: ((MOEllipseShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray).
			view nodes: (otherMethods select: [ :each | each doesExecuteAQuery ] ).
			
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray).
			view nodes: (otherMethods select: [ :each | each doesExecuteAQuery not ]).
			
			view shape line color darker.
			view edges: eachClass internalInvocations
				from: #sender
				toAll: #candidates.
			view horizontalTreeLayout ].	
			
	view shape curvedLine color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
		
	view dominanceTreeLayout
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowWithoutEllipseShapesOn: view [
	"<menuItem: 'Transaction Flow 2' category: 'Visualize'>"

	| interestingClasses allInterestingMethods internalInvocations otherMethods |
	
	interestingClasses := self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ].
	
	view nodes: interestingClasses
		forEach:
			[ :eachClass | 
			allInterestingMethods := eachClass methods select: #isPartOfATransaction.
			otherMethods := eachClass methods difference: allInterestingMethods.
			
			view nodeShape: ( (MORectangleShape width: 7 height: 7 fillColor: Color lightGray) borderColor: Color pink ).
			view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
																and: [ each hasEJBTransactionAttribute not ] ] ).

			view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color lightGray ) ).
			view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
																and: [ each hasEJBTransactionAttribute not ] ] ).

			view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color pink ).
			view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
														and: [ each startATransaction 
															and: [ each couldBeAnEntryPoint ] ] ] ).

			view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker ).
			view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
																and: [ each startATransaction 
																	and: [ each couldBeAnEntryPoint ] ] ] ).

			view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color pink ).
			view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
																and: [ each startAUselessTransaction ] ] ).
	
			view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
			view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
																and: [ each startAUselessTransaction ] ] ).
					
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color cyan) borderColor: Color pink ).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint not
																		and: [ each hasEJBTransactionAttribute ] ] ] ] ).
									
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color cyan) borderColor: Color blue lighter).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery not
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint not
																		and: [ each hasEJBTransactionAttribute ] ] ] ] ).
									
									
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color pink).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery 																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint
																		and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).
							
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker).
			view nodes: (allInterestingMethods select: [ :each | each doesExecuteAQuery not
																and: [ each startAUselessTransaction not 
																	and: [ each couldBeAnEntryPoint
																		and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).
							
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color pink).
			view nodes: (otherMethods select: [ :each | each doesExecuteAQuery ] ).
			
			view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray).
			view nodes: (otherMethods select: [ :each | each doesExecuteAQuery not ]).
			
			view shape line color darker.
			view edges: eachClass internalInvocations
				from: #sender
				toAll: #candidates.
			view horizontalTreeLayout ].	
			
	view shape curvedLine color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
		
	view dominanceTreeLayout.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow [

	"<menuItem: 'Transaction Flow 1' category: 'Mondrian'>"
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowOn: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow2 [
	"<menuItem: 'Transaction Flow 2' category: 'Mondrian'>"
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlow2On: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow2On: view [ 
	"<menuItem: 'Transaction Flow 2' category: 'Visualize'>"
	| interestingClasses allInterestingMethods internalInvocations |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).

	view nodes: interestingClasses forEach: [:eachClass |

		allInterestingMethods := eachClass methods select: #isPartOfATransaction.

		view nodeShape: ( MOEllipseShape width: 7 height: 7 fillColor: Color white).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color white ) ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker ).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color red ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ (each couldBeAnEntryPoint not and: [ each hasEJBTransactionAttributeThatSupportTransactions ]) 
																									or: [ ( each couldBeAnEntryPoint and: [ (each ejbTransactionType asLowercase = 'required') and: [ each startATransaction not ] ] ) ] 
																	] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ (each couldBeAnEntryPoint not and: [ each hasEJBTransactionAttributeThatSupportTransactions ]) 
																									or: [ ( each couldBeAnEntryPoint and: [ (each ejbTransactionType asLowercase = 'required') and: [ each startATransaction not ] ] ) ] 
																	] ] ] ).
														
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asLowercase = 'supports' ] ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asLowercase = 'supports' ] ] ] ] ).												
														
		view shape line color darker.
		view edges: eachClass internalInvocations from: #sender toAll: #candidates.
		view horizontalTreeLayout.
	].
	
	view shape curvedLine color lighter.
	view edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	
	view dominanceTreeLayout.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow3 [
	<menuItem: 'Transaction Flow' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlow3On: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow3On: view [ 
	<mondrianView: 'viewTransactionFlow3On: view '>
	| interestingClasses allInterestingMethods otherMethods |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).

	view nodes: interestingClasses forEach: [:eachClass |

		allInterestingMethods := eachClass methods select: #isPartOfATransaction.
		otherMethods := eachClass methods difference: allInterestingMethods.

		view nodeShape: ( MOEllipseShape width: 7 height: 7 fillColor: Color white).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color white ) ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor:  Color blue darker ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker ).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter lighter ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter lighter ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).
	
		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint
																	and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

		view shape line color darker.
		view edges: eachClass internalInvocations from: #sender toAll: #candidates.
		view horizontalTreeLayout.
	].


	view shape curvedLine color lighter.
	view edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	
	view dominanceTreeLayout.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowOn: view [ 
	"<menuItem: 'Transaction Flow' category: 'Visualize'>"
	
	| interestingClasses allInterestingMethods |

	interestingClasses := ( ( ( ( self select: #hasImplementsABean ) asSet flatCollectAsSet: #withSuperclassHierarchy) flatCollectAsSet: #withDeepInvokedClasses ) select: [:each | each isStub not] ) asSet.

	view nodes: interestingClasses forEach: [:eachClass |
		allInterestingMethods := eachClass methods select: #isPartOfATransaction.

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color veryLightGray) borderColor: Color white).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each hasEJBTransactionAttribute not ] ] ).
		view nodeShape: ( MORectangleShape width: 7 height: 7 fillColor: Color veryLightGray ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
															and: [ each hasEJBTransactionAttribute not ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
													and: [ each startATransaction 
														and: [ each couldBeAnEntryPoint ] ] ] ).
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker ).
		view nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color red ) borderColor: Color white ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery															
															and: [ each startAUselessTransaction ] ] ).
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction ] ] ).

		view nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter ).
		view nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).
		view nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color blue lighter ).
		view nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
															and: [ each startAUselessTransaction not 
																and: [ each couldBeAnEntryPoint not
																	and: [ each hasEJBTransactionAttribute ] ] ] ] ).
		view horizontalTreeLayout.
	].

	"view newShape line; lineColor: #red asColor."
	view edges: self from: #yourself toAll: #superclassHierarchy.
	
	"view edges: ( self flatCollect: [:each | each internalInvocations ] ) from: #invokedBy to: #anyCandidate using: (MOLineShape color: Color transparent)."

	view edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	view dominanceTreeLayout.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueries [
	<menuItem: 'Unsafe queries' category: 'Mondrian'>

	| view |
	view := MOViewRenderer new.
	self viewUnsafeQueriesOn: view.
	view open.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueriesOn: view [ 
	<menuItem: 'Unsafe Query' category: 'Visualize'>
	
	
	| allMethods interestingClasses interestingClassesWithoutLonelyClasses |
	allMethods := ( FAMIXMethodGroup withAll: ( ( self flatCollect: #methodsGroup ) select: #doesExecuteAQuery ) ) deepCalleeMethodsWithoutTransactionPath.
	interestingClasses := FAMIXClassGroup new addAll: ( self select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ).
	interestingClassesWithoutLonelyClasses := interestingClasses 
												reject: [ :class | ( class invokingClasses intersection: interestingClasses ) isEmpty 
																	and: [ ( class invokedClasses intersection: interestingClasses ) isEmpty ] ].

	view nodes: interestingClassesWithoutLonelyClasses forEach: [:eachClass |
		| methods |

		methods := eachClass methods intersection: allMethods.
	
		view nodeShape: ( MORectangleShape width: 7 height: 7 fillColor: Color yellow ).
		view nodes: ( methods select: [ :each | ( each doesCall: 'executeQuery' ) and: [ ( each doesCall: 'executeUpdate' ) not ] ] ).

		view nodeShape: ( MORectangleShape width: 7 height: 7 fillColor: Color orange ).
		view nodes: ( methods select: [ :each | ( each doesCall: 'executeQuery' ) not and: [ ( each doesCall: 'executeUpdate' )  ] ] ).
		
		view nodeShape: ( MORectangleShape width: 7 height: 7 fillColor: Color red ).
		view nodes: ( methods select: [ :each | ( each doesCall: 'executeQuery' ) and: [ each doesCall: 'executeUpdate' ] ] ).
		
		view nodeShape: ((MORectangleShape width: 7 height: 7 fillColor: Color white) borderColor: Color lightGray).
		view nodes: ( methods select: [ :each | each doesExecuteAQuery not ] ).

		view shape line color darker.
		view edges: eachClass internalInvocations from: #sender toAll: #candidates.
		view horizontalTreeLayout 
	].

	view shape line color lighter.
	view edgesFrom: #superclass.

	"view newShape line; lineColor: Color veryLightGray.
	view edges: self mooseModel allInvocations from: #invokedBy to: #anyCandidate."
	
	view shape curvedLine color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
		
	view dominanceTreeLayout
]
