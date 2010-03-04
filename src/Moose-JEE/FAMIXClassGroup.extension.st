Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOQMNOM [
	
	"<property: #'R_NOQM_NOM'
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOQM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> RatioNOTMNOM [
	"<property: #'R_NOTM_NOM'
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOTM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> allClassesOfGroup: anInteger [

	^self select: [:class | class groupNumber = anInteger ].
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> determinGroupStartingFrom: groupNum [
	"This is the algorithm that assigne the group numbers to the elements.
		anExistingGroups is an OrderedCollection containing an OrderedCollection for each group of classes."

	| currentGroupNumber groupsToChange |

	currentGroupNumber := groupNum.
	groupsToChange := OrderedCollection with: currentGroupNumber .
		
	self do: [:class | 
				class groupNumber isNil
					ifTrue: [ class groupNumber: currentGroupNumber ]
					ifFalse: [ "if False means that as been found a class of another hierarchy"
						"determin new group number"
						groupsToChange add: class groupNumber.					
						currentGroupNumber := currentGroupNumber min: class groupNumber.
						"assign class group"
						class groupNumber: currentGroupNumber  ]
			].
		
	^groupsToChange
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> groupClassesConsiderInvokationHierarchy [

| wholeSet groupNumber |

"I should move away this and just invoke"
"startSet := self select: [ :class | class hasImplementsASessionBean ]."
self first mooseModel allClasses resetGroups.

"initialize"
wholeSet := OrderedCollection new.
self do: [:class | wholeSet add: class withDeepInvokedClasses asMooseGroup ].
groupNumber := 1.

wholeSet do: [:classGroup | 
				| changesCollection|
				changesCollection := classGroup determinGroupStartingFrom: groupNumber.
				self updateGroupNumberUsing: changesCollection.		
				groupNumber := groupNumber + 1. ].

]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> resetGroups [
	self do:[:each | each groupNumber: nil].
]

{ #category : #'*Moose-JEE' }
FAMIXClassGroup >> updateGroupNumberUsing: anOrderedCollection [

	(anOrderedCollection size = 1)
		ifFalse: [ 
			| valueToAssign |
			
			valueToAssign := anOrderedCollection min.
			anOrderedCollection remove: valueToAssign.
			
			anOrderedCollection 
					do: [:groupNm |
						self do: [:class | ( class groupNumber = groupNm ) ifTrue: [ class groupNumber: valueToAssign ] ]
					]	
		].
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlow [
	<menuItem: 'Transaction Flow with all methods' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewMethodsWithTransactionFlowOn: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowForBrowserOn: view [
	
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
			
	view shape line color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
	
	view shape line color darker.
	view edgesFrom: #superclass.
	
	view dominanceTreeLayout
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowOn: view [
	
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
			
	view shape line color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
	
	view dominanceTreeLayout
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowWithoutEllipseShapesOn: view [
	
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
FAMIXClassGroup >> viewTransactionFlow3 [
	<menuItem: 'Transaction Flow' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlow3On: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow3On: view [

	| interestingClasses allInterestingMethods otherMethods |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).
	
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
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


	view shape line color lighter.
	view edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	
	"view dominanceTreeLayout."
	view dominanceGrouppedTreeLayout.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayers [
	<menuItem: 'Transaction Flow By Layers' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowByLayersOn: view.
	view open
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayersOn: view [ 
	
	| beans data logic map invocationsMap invoked |


	beans := ( self select: [ :class | class hasImplementsABean ] )asSet asOrderedCollection. 
	"beansWithSuperclassses := (beans flatCollect: [:each | each withSuperclassHierarchy]) asSet asOrderedCollection."

	invoked := ( self select: [ :eachClass | ( eachClass methods select: #isPartOfATransaction ) notEmpty ] ) asSet asOrderedCollection.
	data := invoked select: #isADataLayerClass.
	beans := beans difference: data.

	invoked := invoked  reject: [:each | beans includes: each].
	logic := invoked reject: #isADataLayerClass.
	
	map := IdentityDictionary new.
	data do: [:each | map at: each mooseName put: 3].
	logic do: [:each | map at: each mooseName put: 2].
	beans do: [:each | map at: each mooseName put: 1].
	invocationsMap := beans first mooseModel allClasses flatCollect: [:each | each invokedClasses collect: [:x | each -> x]].

	view umlShape: 'Service Layer'.
	view nodes: beans forEach: [:each | each viewInterestingTransactionMethodsOn: view. view gridLayout. view dominanceTreeLayout.].
"
	view newShape line; invisible.
	view edges: ( invocationsMap reject: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  from: #key to: #value.

	view newShape curvedLine; lineColor: #orange asColor.
	view edges: ( invocationsMap select: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  from: #key to: #value."
	"view newShape line; lineWidth: 4; lineColor: Color red."
	view shape line color: Color darkGray.
	view edges: beans first mooseModel allClasses from: #directSuperclasses to: #yourself.
	view verticalLineLayout verticalGap: 40.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueries [
	"<menuItem: 'Unsafe queries' category: 'Mondrian'>"

	| view |
	view := MOViewRenderer new.
	self viewUnsafeQueriesOn: view.
	view open.
]

{ #category : #'*Moose-JEE-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueriesOn: view [ 	
	
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
	
	view shape line color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
		
	view dominanceTreeLayout
]
