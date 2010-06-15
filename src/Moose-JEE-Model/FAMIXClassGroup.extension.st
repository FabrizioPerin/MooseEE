Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> DTOsConstellation [

	<menuItem: 'DTOs Constellation' category: 'Visualizations'>
	| view |
	view := MOViewRenderer new.
	self DTOsConstellationOn: view.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> DTOsConstellationOn: aView [

	| invoking |
	invoking := ((self flatCollect: #invokingClasses) reject: [:each |
		(self includes: each) or: ['*Test*' match: each name ]]) asSet asMooseGroup.
	"aView shape rectangle size: 20; fillColor: Color lightGray."
	aView shape label text: #name; fontSize: 10.	
	aView interaction menu: #mooseMenuMorph.
	aView nodes: self.
	aView nodes: invoking.
	aView shape line color: Color veryLightGray.
	aView edges: self from: #yourself toAll: #clientClasses.
	aView graphvizLayout neato
]

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> RatioNOQMNOM [
	
	"<property: #'R_NOQM_NOM'
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOQM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> RatioNOTMNOM [
	"<property: #'R_NOTM_NOM'
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOTM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #NOM) ) asFloat ]
]

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> allClassesOfGroup: anInteger [

	^self select: [:class | class groupNumber = anInteger ].
]

{ #category : #'*Moose-JEE-Model' }
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

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> groupClassesConsiderInvokationHierarchy [

| wholeSet groupNumber |

"I should move away this and just invoke"
"startSet := self select: [ :class | class hasImplementsASessionBean ]."
self isEmpty ifFalse: [self first mooseModel allClasses resetGroups].

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

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> resetGroups [
	self do:[:each | each groupNumber: nil].
]

{ #category : #'*Moose-JEE-Model' }
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

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowForBrowserOn: view [
	
	| interestingClasses allInterestingMethods internalInvocations otherMethods tables |
	
	interestingClasses := self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ].
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
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
	
	"Show data base tables"
	tables := (interestingClasses flatCollect: [:class | class mappedRelationalEntities ]).
	view nodes: tables using: ( MORectangleShape new withBorder; text: [:table | table name ] ).
	view shape line color darker.
	view edges: self mooseModel allMaps from: #mapSource to: #mapTarget.
	
"	view shape line color darker.
	view edgesFrom: #superclass."
	
	view dominanceGrouppedTreeLayout.
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow [
	<menuItem: 'Transaction Flow' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowOn: view withAllMethods: false.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow4 [
	<menuItem: 'Transaction Flow TEST' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlow4On: view.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlow4On: aView [

	| interestingClasses allInterestingMethods otherMethods tables internalShape |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
	aView interaction item: 'inspect' action: [:elem | self inspect].
	aView shape rectangle withBorder.
	aView nodes: interestingClasses forEach: [:class |
		
		aView interaction nodraggable.
		(aView shape rectangle text: [:each | each name]) withBorder.
		aView node: class.
		
		"aView interaction forward."
		
		aView interaction nodraggable.
		aView shape rectangle borderColor: Color transparent.
		aView node: class forIt:[
			allInterestingMethods := class methods select: #isPartOfATransaction.
				otherMethods := class methods difference: allInterestingMethods.

				aView nodeShape: ( MOEllipseShape width: 7 height: 7 fillColor: Color lightGray lighter).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
																	and: [ each hasEJBTransactionAttribute not ] ] ).

				aView nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color white ) ).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery not 
																	and: [ each hasEJBTransactionAttribute not ] ] ).

				aView nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color blue ) borderColor:  Color blue darker darker).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery 
															and: [ each startATransaction 
																and: [ each couldBeAnEntryPoint ] ] ] ).

				aView nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color blue ) borderColor: Color blue darker darker).
				aView nodes: ( allInterestingMethods select: [:each | ( each doesExecuteAQuery not ) 
																	and: [ each startATransaction 
																		and: [ each couldBeAnEntryPoint ] ] ] ).

				aView nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker darker).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
																	and: [ each startAUselessTransaction ] ] ).

				aView nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color red ) borderColor: Color red darker darker).
				aView nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
																	and: [ each startAUselessTransaction ] ] ).

				aView nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
																	and: [ each startAUselessTransaction not 
																		and: [ each couldBeAnEntryPoint not
																			and: [ each hasEJBTransactionAttribute ] ] ] ] ).

				aView nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color cyan ) borderColor: Color cyan darker darker ).
				aView nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
																	and: [ each startAUselessTransaction not 
																		and: [ each couldBeAnEntryPoint not
																			and: [ each hasEJBTransactionAttribute ] ] ] ] ).
	
				aView nodeShape: ( ( MOEllipseShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
				aView nodes: ( allInterestingMethods select: [:each | each doesExecuteAQuery
																	and: [ each startAUselessTransaction not 
																		and: [ each couldBeAnEntryPoint
																			and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

				aView nodeShape: ( ( MORectangleShape width: 7 height: 7 fillColor: Color orange) borderColor: Color orange darker darker).
				aView nodes: ( allInterestingMethods select: [:each | (each doesExecuteAQuery not) 
																	and: [ each startAUselessTransaction not 
																		and: [ each couldBeAnEntryPoint
																			and: [ each ejbTransactionType asString asLowercase = 'supports' ] ] ] ] ).

				aView shape line color darker.
				aView edges: class internalInvocations from: #sender toAll: #candidates.
				aView horizontalTreeLayout.].
	
			aView verticalLineLayout gapSize:0; stretchVertically.
			].
		
	aView shape line color lighter.
	aView edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	
	"Show data base tables"
	tables := (interestingClasses flatCollect: [:class | class mappedRelationalEntities ]).
	aView nodes: tables using: ( MORectangleShape new withBorder; text: [:table | table name ] ).
	aView shape line color darker.
	aView edges: self mooseModel allMaps from: #mapSource to: #mapTarget.

	"aView dominanceTreeLayout."
	aView dominanceGrouppedTreeLayout.
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayers [
	<menuItem: 'Transaction Flow By Layers' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowByLayersOn: view withAllMethods: false.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayersOn: view withAllMethods: aBoolean [
	
	| beans data logic map invocationsMap invoked |

	beans := ( self select: [ :class | class hasImplementsASessionBean ] )asSet asOrderedCollection. 
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

	view interaction nodraggable.
	view shape rectangle withBorder.
	view node: 'Service Layer' forIt:[
		
			view interaction nodraggable.
			view shape rectangle text: 'Service Layer'; fontSize: 10; borderColor: Color transparent; textAlignment: #left.
			view node: 'Service Layer'.
			
			view interaction nodraggable.
			view interaction item: 'inspect' action: [:elem | beans inspect].
			view shape rectangle withBorder.
			view node: 'Service Layer Content' forIt:[
					view interaction nodraggable.
					view shape rectangle withBorder.
					view nodes: beans forEach:[:each | 
							view interaction item: 'inspect' action: [:elem | each inspect].
							aBoolean 
								ifTrue: [each viewTransactionalMethodsOn: view.]
								ifFalse: [
										each viewMethodsHighlightingTransactionalOn: view.
										view gridLayout.]].
			].

			view verticalLineLayout gapSize:0; stretchHorizontally.
	].

	view interaction nodraggable.
	view shape rectangle withBorder.
	view node: 'Business Layer' forIt:[
		
			view interaction nodraggable.
			view shape rectangle text: 'Business Layer'; fontSize: 10; borderColor: Color transparent; textAlignment: #left.
			view node: 'Business Layer'.
			
			view interaction nodraggable.
			view interaction item: 'inspect' action: [:elem | logic inspect].
			view shape rectangle withBorder.
			view node: 'Business Layer Content' forIt:[
					view interaction nodraggable.
					view shape rectangle withBorder.
					view nodes: logic forEach:[:each | 
							view interaction item: 'inspect' action: [:elem | each inspect].
							aBoolean 
								ifTrue: [each viewTransactionalMethodsOn: view.]
								ifFalse: [
										each viewMethodsHighlightingTransactionalOn: view.
										view gridLayout.]].
			].

			view verticalLineLayout gapSize:0; stretchHorizontally.
	].

	view interaction nodraggable.
	view shape rectangle withBorder.
	view node: 'Data Layer' forIt:[
		
			view interaction nodraggable.
			view shape rectangle text: 'Data Layer'; fontSize: 10; borderColor: Color transparent; textAlignment: #left.
			view node: 'Data Layer'.
			
			view interaction nodraggable.
			view interaction item: 'inspect' action: [:elem | data inspect].
			view shape rectangle withBorder.
			view node: 'Data Layer Content' forIt:[
					view interaction nodraggable.
					view shape rectangle withBorder.
					view nodes: data forEach:[:each | 
							view interaction item: 'inspect' action: [:elem | each inspect].
							aBoolean 
								ifTrue: [each viewTransactionalMethodsOn: view.]
								ifFalse: [
										each viewMethodsHighlightingTransactionalOn: view.
										view gridLayout.]].
			].

			view verticalLineLayout gapSize:0; stretchHorizontally.
	].
	

	view shape line color: Color transparent.
	view 
		edges: ( invocationsMap reject: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  
		from: #key to: #value.

	view shape line color: Color lightGray.
	view 
		edges: ( invocationsMap select: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  
		from: #key to: #value.
	
	view shape line color: Color darkGray.
	view edges: beans first mooseModel allClasses from: #directSuperclasses to: #yourself.
	view verticalLineLayout verticalGap: 40.
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayersWithAllMethods [
	<menuItem: 'Transaction Flow by layers with alla methods' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowByLayersOn: view withAllMethods: true.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowOn: view withAllMethods: aBoolean [

	| interestingClasses allInterestingMethods otherMethods tables |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
	"interestingClasses := ((self select: #hasImplementsASessionBean) flatCollect: #withDeepInvokedClasses) asSet asMooseGroup.
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy."
	
	view nodes: interestingClasses forEach: [:eachClass |
		
			aBoolean 
				ifTrue:[eachClass viewMethodsHighlightingTransactionalOn: view]
				ifFalse: [eachClass  viewTransactionalMethodsOn: view].
	].


	view shape line color lighter.
	view edges: self mooseModel allClasses from: #yourself toAll: #invokedClasses.
	
	"Show data base tables"
	tables := (interestingClasses flatCollect: [:class | class mappedRelationalEntities ]).
	view nodes: tables using: ( MORectangleShape new withBorder; text: [:table | table name ] ).
	view shape line color darker.
	view edges: self mooseModel allMaps from: #mapSource to: #mapTarget.
	
	"view dominanceTreeLayout."
	view dominanceGrouppedTreeLayout.
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewTransactionFlowWithAllMethods [
	<menuItem: 'Transaction Flow with all methods' category: 'Mondrian'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowOn: view withAllMethods: true.
	view open
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueries [
	<menuItem: 'Unsafe queries' category: 'Mondrian'>

	| view |
	view := MOViewRenderer new.
	self viewUnsafeQueriesOn: view.
	view open.
]

{ #category : #'*Moose-JEE-Model-mondrianvisualizations' }
FAMIXClassGroup >> viewUnsafeQueriesOn: view [ 	
	
	| allMethods interestingClasses interestingClassesWithoutLonelyClasses interestingClassesWithoutTests |
	
	allMethods := ( FAMIXMethodGroup withAll: ( ( self flatCollect: #methodsGroup ) select: #doesExecuteAQuery ) ) deepCalleeMethodsWithoutTransactionPath.
	interestingClasses := FAMIXClassGroup new addAll: ( self select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ).
	(interestingClasses select: [:class | (class invokingClasses intersection: interestingClasses) isEmpty ]) groupClassesConsiderInvokationHierarchy.
	
	interestingClassesWithoutTests := interestingClasses reject: [ :class | ( class name includesSubString: 'Test') or:[ class name includesSubString: 'test' ] ].
	"(interestingClassesWithoutTests select: [:class | class incomingReferences isEmpty ]) groupClassesConsiderInvokationHierarchy."
	
	interestingClassesWithoutLonelyClasses := interestingClasses select: [ :class | ( class name includesSubString: 'Test') or:[ class name includesSubString: 'test' ] ].
	"(interestingClassesWithoutLonelyClasses select: [:class | class incomingInvocations isEmpty ]) groupClassesConsiderInvokationHierarchy."

	view shape rectangle withBorder.	
	view nodes: interestingClassesWithoutTests forEach: [:eachClass |
		eachClass viewMethodsIncludeIn: allMethods ForUnsafeQueriesOn: view ].

	view shape rectangle withBorder; borderColor: Color lightGray.
	view nodes: interestingClassesWithoutLonelyClasses forEach: [:eachClass | 
			eachClass viewMethodsIncludeIn: allMethods ForUnsafeQueriesOn: view ].

	view shape line color lighter.
	view edgesFrom: #superclass.

	"view newShape line; lineColor: Color veryLightGray.
	view edges: self mooseModel allInvocations from: #invokedBy to: #anyCandidate."
	
	view shape line color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses.
		
	view dominanceGrouppedTreeLayout
]
