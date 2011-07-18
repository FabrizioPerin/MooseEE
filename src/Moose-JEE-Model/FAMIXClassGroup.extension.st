Extension { #name : #FAMIXClassGroup }

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsConstellation [

	"<menuItem: 'DTOs Constellation' category: 'JEAs Visualizations WORKINGON'>"
	
	| view boregexe dummyregex |
	view := MOViewRenderer new.
	boregexe := '.*BO' asRegex.
	dummyregex := '.*Dummy.*' asRegex.
	( ( self select: [:each | boregexe matches: each name ] ) reject: [:each | each isTestClass or: [dummyregex matches: each name ] ] ) DTOsConstellationOn: view.
	^ view openWithStatusbar title: 'DTOs Constellation'
	
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsConstellationOn: aView [

	| invoking |
	invoking := ((self flatCollect: #invokingClasses) reject: [:each |
		(self includes: each) or: [('.*Test.*' asRegexIgnoringCase matches: each name) or: ['.*Dummy.*' asRegexIgnoringCase matches: each name ]]]) asSet asMooseGroup.
	aView shape rectangle size: 8; fillColor: Color lightGray.
	"aView shape label text: #name; fontSize: 8.	"
	aView interaction menu: #mooseMenuMorph.
	aView nodes: self.
	aView interaction menu: #mooseMenuMorph.
	aView nodes: invoking.
	"aView shape arrowedLine color: Color veryLightGray; arrowSize: 4."
	aView shape line color: Color veryLightGray.
	aView edges: self from: #yourself toAll: #clientClasses.
	aView graphvizLayout neato.
	
aView shape line color: Color black; width: 2..
	aView 
		edges: self mooseModel allDuplications 
		from: [:each | each referenceCode entity] 
		to: [:each | each duplicateCode entity].	
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsConstellationOnSelection [

	"<menuItem: 'DTOs Constellation On Selection' category: 'JEAs Visualizations WORKINGON'>"
	
	| view |
	view := MOViewRenderer new.
	self DTOsConstellationOn: view.
	^view openWithStatusbar title: 'DTOs Constellation On Selection'
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsConstellationTestVO [

	"<menuItem: 'DTOs Constellation test VO' category: 'JEAs Visualizations WORKINGON'>"
	
	| view regexe |
	view := MOViewRenderer new.
	regexe := '.*VO' asRegexIgnoringCase.
	(self select: [:each | regexe matches: each name ]) DTOsConstellationOn: view.
	^ view openWithStatusbar title: 'DTOs Constellation test VO'
	
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsDuplicationConstellation [

	"<menuItem: 'DTOs Duplication Constellation' category: 'JEAs Visualizations WORKINGON'>"
	
	| view regexe |
	view := MOViewRenderer new.
	regexe := '.*BO' asRegexIgnoringCase.
	(self select: [:each | regexe matches: each name ]) DTOsDuplicationsConstellationOn: view.
	^ view openWithStatusbar title: 'DTOs Duplication Constellation'
	
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> DTOsDuplicationsConstellationOn: aView [

	| invoking |
	invoking := ((self flatCollect: #invokingClasses) reject: [:each |
		(self includes: each) or: [('.*Test.*' asRegexIgnoringCase matches: each name) or: ['.*Dummy.*' asRegexIgnoringCase matches: each name ]]]) asSet asMooseGroup.
	"aView shape rectangle size: 8; fillColor: Color lightGray."
	aView shape label text: #name; fontSize: 8.
	aView interaction menu: #mooseMenuMorph.
	aView nodes: self.
	aView nodes: invoking.
	"aView shape arrowedLine color: Color veryLightGray; arrowSize: 4."
	aView shape line color: Color veryLightGray.
	aView edges: self from: #yourself toAll: #clientClasses.
	
	aView graphvizLayout neato.
	
	aView shape line color: Color red.
	aView 
		edges: self mooseModel allDuplications 
		from: [:each | each referenceCode entity] 
		to: [:each | each duplicateCode entity].	
]

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> RatioNOQMNOM [
	
	"<property: #'R_NOQM_NOM'
		longName: 'Ratio Number Of Querying Methods Number Of Methods'
		description: 'Ratio between the number of methods that execute a Query and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOQM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOQM ) / ( self sumOfPropertyNamed: #WIM) ) asFloat ]
]

{ #category : #'*Moose-JEE-Model' }
FAMIXClassGroup >> RatioNOTMNOM [
	"<property: #'R_NOTM_NOM'
		longName: 'Ratio Number Of Transaction Methods Number Of Methods'
		description: 'Ratio between the number of methods involved in a transaction and the number of methods'
	>"
	^self lookUpPropertyNamed: #'R_NOTM_NOM' computedAs: [ ( ( self sumOfPropertyNamed: #NOTM ) / ( self sumOfPropertyNamed: #WIM) ) asFloat ]
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
FAMIXClassGroup >> ranked [
	^(((PageRank new
	referenced: #clientClasses;
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea ]) asMooseGroup
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

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewClassRank [
	<menuItem: 'Class Rank' category: 'Visualize'>
	| view |
	view := MOViewRenderer new.
	self viewClassRankOn: view.
	^ view openWithStatusbar title: 'Class Rank'
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewClassRankOn: view [ 
	| objects |
	
	objects := (self reject: #isTestClass) ranked.
	view shape label
		text: [:each | ' ' , each key name , (each value integerPart asString , '.' , each value fractionPart asString asString sliceFrom: 1 to: 3 )].
	
	view nodes: objects.
	view bottomFlowLayout maxWidth: 600
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewClassesHighlightingExecutedQueriesOn: view [

	| cyan magenta yellow black red green blue |
	
	cyan := ( self select: [ :class | class methods anySatisfy: [:method | ( method doesInvoke: 'executeQuery' ) and: [ ( method doesInvoke: 'executeUpdate' ) not ] ] ] ).
	magenta := ( self select: [ :class | class methods anySatisfy: [:method | ( method doesInvoke: 'executeQuery' ) not and: [ ( method doesInvoke: 'executeUpdate' ) ] ] ] ).
	yellow := ( self select: [ :class | class methods anySatisfy: [:method | ( method doesInvoke: 'executeQuery' ) not and: [ ( method doesInvoke: 'executeUpdate' ) not ] ] ] ).
	
	black :=  ((cyan intersect: magenta) intersect: yellow).
	
	red := (yellow intersect: magenta) difference: black.
	green := (cyan intersect: yellow) difference: black.
	blue := (cyan intersect: magenta) difference: black.
	
	view shape rectangle fillColor: Color black.
	view nodes: black.
	
	view shape rectangle fillColor: Color green; borderColor:  Color green darker darker.
	view nodes: green.
	
	view shape rectangle fillColor: Color red; borderColor:  Color red darker darker.
	view nodes: red.
	
	view shape rectangle fillColor: Color blue; borderColor:  Color blue darker darker.
	view nodes: blue.
	
	view shape rectangle fillColor: Color yellow; borderColor:  Color yellow darker darker.
	view nodes: ((yellow difference: cyan) difference: magenta).
	
	view shape rectangle fillColor: Color cyan; borderColor:  Color cyan darker darker.
	view nodes: ((cyan difference: magenta) difference: yellow).
	
	view shape rectangle fillColor: Color magenta; borderColor:  Color magenta darker darker.
	view nodes: ((magenta difference: cyan) difference: yellow).

	
	"view shape line color lighter.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #invokedClasses."
		
	view shape line color: Color lightGray.
	view edges: self mooseModel allClasses
		from: #yourself
		toAll: #subClasses.
	view treeLayout.
	

]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewMethodsWithTransactionFlowForBrowserOn: view [
	
	| interestingClasses allInterestingMethods internalInvocations otherMethods tables |
	
	interestingClasses := self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ].
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
	view nodes: interestingClasses
		forEach: [ :eachClass | 
			
			eachClass viewMethodsHighlightingTransactionalOn: view.
			
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

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewSystemByLayerOn: view [

	| serviceLayer dataLayer logicLayer |

	serviceLayer := self mooseModel allWithType: MJFAMIXServiceLayer.
	dataLayer := (self mooseModel allWithType: MJFAMIXDataLayer) first.
	logicLayer := self mooseModel allWithType: MJFAMIXLogicLayer.
	   
	
	view shape layerShape.
	view interaction nodraggable.
	view node: dataLayer forIt: [
		
		view interaction nodraggable.
		view interaction menuMorphBlock: [:each | each mooseMenuMorph].  
		view shape rectangle withBorder.
		view nodes: dataLayer containedClasses forEach: [:class | 
					 class viewMethodsIncludeIn: class methods ForUnsafeQueriesOn: view].
		
		view shape line color: Color veryLightGray.  
		view edges: dataLayer containedClasses from: #superclass to: #yourself.
		
		view treeLayout].
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewSystemByLayers [
	<menuItem: 'System by layer' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewSystemByLayerOn: view.
	^view openWithStatusbar title: 'System by layer'
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewSystemComplexityByLayerOn: view [

	| beans data logic map invocationsMap invoked aBoolean |

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
	view node: 'Service Layer' forIt: [
		
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

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewTransactionFlow [
	<menuItem: 'Transaction Flow' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowOn: view withAllMethods: false.
	^view openWithStatusbar title: 'Transaction Flow'
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayers [
	<menuItem: 'Server Layers' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowByLayersOn: view withAllMethods: false.
	^view openWithStatusbar title: 'Server Layers'.
]

{ #category : #'*Moose-JEE-Model-visualizations' }
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
								ifFalse: [each viewTransactionalMethodsOn: view]
								ifTrue: [
									each viewMethodsHighlightingTransactionalOn: view.
									view gridLayout]].
					view shape line color: Color transparent.
					view edges: beans from: #yourself toAll: #invokedClasses.
					view treeLayout. 
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
								ifFalse: [each viewTransactionalMethodsOn: view]
								ifTrue: [
									each viewMethodsHighlightingTransactionalOn: view.
									view gridLayout]].
					view shape line color: Color transparent.
					view edges: logic from: #yourself toAll: #invokedClasses.
					view treeLayout. 
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
								ifFalse: [each viewTransactionalMethodsOn: view]
								ifTrue: [
									each viewMethodsHighlightingTransactionalOn: view.
									view gridLayout]].
					
					view shape line color: Color transparent.
					view edges: data from: #yourself toAll: #invokedClasses.
					view dominanceTreeLayout. 
			].

			view verticalLineLayout gapSize:0; stretchHorizontally.
	].
	

	"view shape line color: Color transparent.
	view 
		edges: ( invocationsMap reject: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  
		from: #key to: #value."

	view shape line color: Color lightGray.
	view 
		edges: ( invocationsMap select: [:assoc | ((map at: (assoc key mooseName) ifAbsent:[3]) - (map at: (assoc value mooseName) ifAbsent:[2])) abs = 2 ])  
		from: #key to: #value.
	
	"view shape line color: Color darkGray."
	"view shape line color: Color transparent.
	view edges: beans first mooseModel allClasses from: #directSuperclasses to: #yourself"
	view verticalLineLayout verticalGap: 40.
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewTransactionFlowByLayersWithAllMethods [
	<menuItem: 'Server Layers with alla methods' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowByLayersOn: view withAllMethods: true.
	^view openWithStatusbar title: 'Server Layers with all methods'.
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewTransactionFlowOn: view withAllMethods: aBoolean [

	| interestingClasses allInterestingMethods otherMethods tables |

	interestingClasses := ( self select: [ :eachClass | eachClass methods anySatisfy: #isPartOfATransaction ] ).
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy.
	
	"interestingClasses := ((self select: #hasImplementsASessionBean) flatCollect: #withDeepInvokedClasses) asSet asMooseGroup.
	(interestingClasses select: #hasImplementsABean) groupClassesConsiderInvokationHierarchy."
	
	view nodes: interestingClasses forEach: [:eachClass |		
			aBoolean 
				ifTrue:[eachClass viewMethodsHighlightingTransactionalOn: view]
				ifFalse: [eachClass  viewTransactionalMethodsOn: view] ].

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

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewTransactionFlowWithAllMethods [
	<menuItem: 'Transaction Flow with all methods' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTransactionFlowOn: view withAllMethods: true.
	^view openWithStatusbar title: 'Transaction Flow with all methods'.
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewUnsafeQueries [
	<menuItem: 'Unsafe queries' category: 'JEAs Visualizations'>

	| view |
	view := MOViewRenderer new.
	self viewUnsafeQueriesOn: view.
	^view openWithStatusbar title: 'Unsafe queries'.
]

{ #category : #'*Moose-JEE-Model-visualizations' }
FAMIXClassGroup >> viewUnsafeQueriesOn: view [ 	
	
	| allMethods interestingClasses interestingClassesWithoutLonelyClasses interestingClassesWithoutTests |
	
	allMethods := ( FAMIXMethodGroup withAll: ( ( ( self flatCollect: #methodsGroup ) select: #doesExecuteAQuery ) reject: #startATransaction ) ) deepCalleeMethodsWithoutTransactionPath.
	interestingClasses := FAMIXClassGroup new addAll: ( self select: [ :eachClass | (eachClass methods intersection: allMethods) notEmpty ] ).
	(interestingClasses select: [:class | (class invokingClasses intersection: interestingClasses) isEmpty ]) groupClassesConsiderInvokationHierarchy.
	
	interestingClassesWithoutTests := interestingClasses reject: [ :class | ( class name includesSubString: 'Test') or:[ class name includesSubString: 'test' ] ].
	"(interestingClassesWithoutTests select: [:class | class incomingReferences isEmpty ]) groupClassesConsiderInvokationHierarchy."
	
	interestingClassesWithoutLonelyClasses := interestingClasses select: [ :class | ( class name includesSubString: 'Test') or:[ class name includesSubString: 'test' ] ].
	"(interestingClassesWithoutLonelyClasses select: [:class | class incomingInvocations isEmpty ]) groupClassesConsiderInvokationHierarchy."

	view shape rectangle withBorder; borderColor: Color lightGray.	
	view nodes: interestingClassesWithoutTests forEach: [:eachClass |
		eachClass viewMethodsIncludeIn: allMethods ForUnsafeQueriesOn: view ].

	view shape rectangle withBorder.
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
