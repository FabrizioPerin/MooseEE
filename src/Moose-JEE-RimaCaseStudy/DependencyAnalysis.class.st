Class {
	#name : #DependencyAnalysis,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-RimaCaseStudy'
}

{ #category : #'as yet unclassified' }
DependencyAnalysis class >> allClassesForScreens [
	^#(
X_HR_Job 
I_HR_Job
X_HR_Constract
I_HR_Constract
X_HR_Department
I_HR_Department
X_HR_Employee
I_HR_Employee
X_R_ContactInterest
I_R_ContactInterest
X_C_BPartner
I_C_BPartner
X_C_BP_Employee_Acct
I_C_BP_Employee_Acct
X_HR_Attribute
I_HR_Attribute
X_C_BP_BankAccount
I_C_BP_BankAccount
X_C_BPartner_Location
I_C_BPartner_Location
X_AD_User
I_AD_User
X_A_Registration
I_A_Registration
X_A_RegistrationValue
I_A_RegistrationValue
X_A_RegistrationAttribute
I_A_RegistrationAttribute
X_A_RegistrationProduct
I_A_RegistrationProduct
X_A_Depreciation_Entry
I_A_Depreciation_Entry
X_A_Depreciation_Entry
I_A_Depreciation_Entry
X_M_Product
I_M_Product
X_M_Product_Costing
I_M_Product_Costing
X_M_Cost
I_M_Cost
X_M_CostDetail
I_M_CostDetail
X_M_CostQueue
I_M_CostQueue
)
]

{ #category : #'as yet unclassified' }
DependencyAnalysis class >> allInterfacesForScreens [
	^#(
I_HR_Job
I_HR_Constract
I_HR_Department
I_HR_Employee
I_R_ContactInterest
I_C_BPartner
I_C_BP_Employee_Acct
I_HR_Attribute
I_C_BP_BankAccount
I_C_BPartner_Location
I_AD_User
I_A_Registration
I_A_RegistrationValue
I_A_RegistrationAttribute
I_A_RegistrationProduct
I_A_Depreciation_Entry
I_A_Depreciation_Entry
I_M_Product
I_M_Product_Costing
I_M_Cost
I_M_CostDetail
I_M_CostQueue
)
]

{ #category : #'as yet unclassified' }
DependencyAnalysis class >> associationsInterfacesScreens [
	| out |
	out := OrderedCollection new.
	out add: 'I_M_Product' -> ('product cost' -> 'Select Product').
	out add: 'I_M_Product_Costing' -> ('product cost' -> 'Costing').
	out add: 'I_M_Cost' -> ('product cost' -> 'Product Costs').
	out add: 'I_M_CostDetail' -> ('product cost' -> 'Cost Detail').
	out add: 'I_M_CostQueue' -> ('product cost' -> 'Cost Queue').
	
	out add: 'I_A_Depreciation_Entry' -> ('Split Asset Entry' -> 'Create Split Asset Entry').
	out add: 'I_A_Depreciation_Entry' -> ('Transfer Asset Entry' -> 'Create Asset Transfer Entry').

	out add: 'I_A_Registration' -> ('Registration' -> 'Registration').
	out add: 'I_A_RegistrationValue' -> ('Registration' -> 'value').
	out add: 'I_A_RegistrationAttribute' -> ('Registration Attribute' -> 'attribute').
	out add: 'I_A_RegistrationProduct' -> ('Registration' -> 'Product').

	out add: 'I_HR_Job' -> ('Payroll Job' -> 'Job').
	out add: 'I_HR_Constract' -> ('Payroll Contract' -> 'Contract').
	out add: 'I_HR_Department' -> ('Payroll Department' -> 'Department').

	out add: 'I_HR_Employee' -> ('Payroll Employee' -> 'Employee').
	out add: 'I_R_ContactInterest' -> ('Payroll Employee' -> 'Interest Area').
	out add: 'I_C_BPartner' -> ('Payroll Employee' -> 'Business partner').
	out add: 'I_C_BP_Employee_Acct' -> ('Payroll Employee' -> 'Employee accounting').
	out add: 'I_HR_Attribute' -> ('Payroll Employee' -> 'Attributes').
	out add: 'I_C_BP_BankAccount' -> ('Payroll Employee' -> 'Bank Account').
	out add: 'I_C_BPartner_Location' -> ('Payroll Employee' -> 'Location').
	out add: 'I_AD_User' -> ('Payroll Employee' -> 'Contract User').
	
	^out

]

{ #category : #'as yet unclassified' }
DependencyAnalysis class >> classesForScreens [
	^#(
X_HR_Job 
X_HR_Constract
X_HR_Department
X_HR_Employee
X_R_ContactInterest
X_C_BPartner
X_C_BP_Employee_Acct
X_HR_Attribute
X_C_BP_BankAccount
X_C_BPartner_Location
X_AD_User
X_A_Registration
X_A_RegistrationValue
X_A_RegistrationAttribute
X_A_RegistrationProduct
X_A_Depreciation_Entry
X_A_Depreciation_Entry
X_M_Product
X_M_Product_Costing
X_M_Cost
X_M_CostDetail
X_M_CostQueue
)
]

{ #category : #'as yet unclassified' }
DependencyAnalysis class >> on: aModel [
	^self new targetModel: aModel
]

{ #category : #now }
DependencyAnalysis >> allInterestingElementInTheTargetModel [
	"Apparently the classes that are generate from the database table are the one that subclass PO.java and 
	start with 'X_' (for the classes) or 'I_' (for the interface). 
	So this method return all those elements that are contained into the target model"
	
	| relevantClasses relevantInterfaces |

	relevantClasses := (targetModel allClasses select: [:class | class name = 'PO' ]) first subInheritances collect: [:each | each subclass].
	relevantClasses := (relevantClasses select: [:class | 'X_*' match: class name ]) reject: #isStub.

	relevantInterfaces := (relevantClasses flatCollect: [:class | class implementedInterfaces ]) asSet reject: #isStub.
	relevantInterfaces := (relevantInterfaces select: [:interface | 'I_*' match: interface name]).
	
	^relevantClasses union: relevantInterfaces.
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesIn [
	| interf4scr result normalizationFactor |
	interf4scr := self interfaces4ScreensIn.
	result := OrderedCollection new.
	normalizationFactor := self identifyCommonRefereeClassesIn size.
	(1 to: interf4scr size)
		do: [ :rowIndex | 
			| fromClass fromClassInvokingClasses |
			fromClass := interf4scr at: rowIndex.
			fromClassInvokingClasses := fromClass referencingTypes asSet.
			(rowIndex + 1 to: interf4scr size)
				do: [ :colIndex | 
					| toClass toClassInvokingClasses size edge |
					toClass := interf4scr at: colIndex.
					toClassInvokingClasses := toClass referencingTypes asSet.
					size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
					size > normalizationFactor
						ifTrue: [ 
							edge := MalWeightedEdge with: targetModel.
							edge from: fromClass.
							edge to: toClass.
							edge weight: size - normalizationFactor.
							result add: edge ] ] ].
	^ result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWDAndEdges [
	| interf4scr deps view result commonTypes |
	
	interf4scr := self interfaces4ScreensIn.
	result := OrderedCollection new.
	commonTypes := self identifyCommonRefereeClassesIn.
	
	(1 to: interf4scr size) 
		do: [ :rowIndex | 
			| fromClass fromClassInvokingClasses |
			
			fromClass := interf4scr at: rowIndex.
			fromClassInvokingClasses := fromClass referencingTypes asSet.
			
			(rowIndex + 1 to: interf4scr size)
				do: [ :colIndex | 
					| toClass toClassInvokingClasses edge interestingClasses |
					toClass := interf4scr at: colIndex.
					toClassInvokingClasses := toClass referencingTypes asSet.
					interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses)
						reject: [ :each | commonTypes includes: each ].
						
					interestingClasses size > 0
						ifTrue: [ 
							(result anySatisfy: [:each | (each from = fromClass) and: [(each to = toClass)]]) 
								ifFalse: [
									edge := MalWeightedEdge with: targetModel.
									edge from: fromClass.
									edge to: toClass.
									edge weight: interestingClasses.
									result add: edge ]
								ifTrue: [Transcript show: ('from: ', fromClass asString , ' to: ' , toClass asString) ] ] ] ].
	^ result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWDAndEdgesOnAllSystem [
	| generatedClasses deps view result commonTypes |
	
	generatedClasses := self allInterestingElementInTheTargetModel asOrderedCollection.
	result := OrderedCollection new.
	commonTypes := self identifyCommonRefereeClassesFor: generatedClasses.
	
	(1 to: generatedClasses size) 
		do: [ :rowIndex | 
			| fromClass fromClassInvokingClasses |
			
			fromClass := generatedClasses at: rowIndex.
			fromClassInvokingClasses := fromClass referencingTypes asSet.
			
			(rowIndex + 1 to: generatedClasses size)
				do: [ :colIndex | 
					| toClass toClassInvokingClasses edge interestingClasses |
					toClass := generatedClasses at: colIndex.
					toClassInvokingClasses := toClass referencingTypes asSet.
					interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses)
						reject: [ :each | commonTypes includes: each ].
						
					interestingClasses size > 0
						ifTrue: [ 
							edge := MalWeightedEdge with: targetModel.
							edge from: fromClass.
							edge to: toClass.
							edge weight: interestingClasses.
							result add: edge ] ] ].
	^ result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWDIn [
	| interf4scr deps view result commonTypes |
	interf4scr := self interfaces4ScreensIn.
	result := OrderedCollection new.
	commonTypes := self identifyCommonRefereeClassesIn.
	(1 to: interf4scr size)
		do: [ :rowIndex | 
			| fromClass fromClassInvokingClasses |
			fromClass := interf4scr at: rowIndex.
			fromClassInvokingClasses := fromClass referencingTypes asSet.
			(rowIndex + 1 to: interf4scr size)
				do: [ :colIndex | 
					| toClass toClassInvokingClasses edge interestingClasses |
					toClass := interf4scr at: colIndex.
					toClassInvokingClasses := toClass referencingTypes asSet.
					interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses)
						reject: [ :each | commonTypes includes: each ].
					interestingClasses size > 0
						ifTrue: [ result add: fromClass -> toClass -> interestingClasses ] ] ].
	^ result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWithDetails [

	| classes4screens result commonClasses normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new.
	commonClasses := self identifyCommonClasses reject: #isStub.
	normalizationFactor := commonClasses size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge interestingClasses |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses) reject: [:each | commonClasses includes: each ].   
			
			(interestingClasses size > 0) ifTrue: [
				edge := MalWeightedEdge with: targetModel .
				edge from: fromClass.
				edge to: toClass.
				edge weight: interestingClasses.
				
				result add: (fromClass -> toClass -> interestingClasses).
				]]].
			
	
	^result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWithDetailsInTheEdges [
	| classes4screens result commonClasses normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new.
	commonClasses := self identifyCommonClasses reject: #isStub.
	normalizationFactor := commonClasses size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge interestingClasses |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses) reject: [:each | commonClasses includes: each ].
			
			(interestingClasses size > 0) ifTrue: [
				edge := MalWeightedEdge with: targetModel .
				edge from: fromClass.
				edge to: toClass.
				edge weight: interestingClasses.
				
				result add: edge.
				]]].
			
	
	^result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingOnTables [
	| result tableGroup index |
	
	result := OrderedCollection new.
	tableGroup := targetModel allTables.
	index := 1.
	
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1
		to: (tableGroup size * tableGroup size) asInteger
		during: [ :bar | 
			bar value: index.
			
			(1 to: tableGroup size)
				do: [ :rowIndex | 
					| table interestingFKAssocOfRowTable referencingTables |
					
					table := tableGroup at: rowIndex.
					interestingFKAssocOfRowTable := targetModel allFKAssociations select: [ :fkAssoc | table columns includes: fkAssoc targetColumn ].
					referencingTables := (interestingFKAssocOfRowTable collect: [:each | each sourceColumn ownerTable]) asSet.
					  
					
					(rowIndex + 1 to: tableGroup size)
						do: [ :colIndex |
								| commonTables interestingFKAssocOfColTable |
									
								interestingFKAssocOfColTable :=  targetModel allFKAssociations select: [ :fkAssoc | (tableGroup at: colIndex) columns includes: fkAssoc targetColumn ].
								commonTables := referencingTables intersection: (interestingFKAssocOfColTable collect: [:each | each sourceColumn ownerTable]) asSet.
																		
								commonTables size > 0
									ifTrue: [ 
										| edge |
										edge := MalWeightedEdge with: targetModel.
										edge from: (tableGroup at: colIndex).
										edge to: table.
										edge weight: commonTables.
										result add: edge].
							index := index + 1.
							bar value: index ] ] ].
	^ result
]

{ #category : #computations }
DependencyAnalysis >> computeCouplingThroughInterfacesOn [
	| allClasses allEntity result interfaces4screens commonClasses |
	
	allClasses :=  targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].

	allEntity := allClasses union: (allClasses flatCollect: [:each | each implementedInterfaces]).
	allEntity := allEntity union: (allEntity flatCollect: [:each | each clientClasses]).
	allEntity := allEntity union: (allEntity flatCollect: [:each | each incomingAccesses collect: [:access | access accessor belongsTo]]).
	
	allEntity := allEntity asSet.

	result := OrderedCollection new.
	
	(1 to: interfaces4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := interfaces4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokingClasses reject: #isStub) asSet.
		
		((rowIndex +1) to: interfaces4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge interestingClasses |
			toClass := interfaces4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses) reject: [:each | commonClasses includes: each ].   
			
			(interestingClasses size > 0) ifTrue: [
		"		edge := MalWeightedEdge with: aModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor)."
				
				result add: (fromClass -> toClass -> interestingClasses).
				]]].
			
	
	^result
]

{ #category : #computations }
DependencyAnalysis >> computeCouplingWithNormalizationAndWithStubClassesOn [
	| classes4screens result normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	normalizationFactor := self identifyCommonClasses size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := fromClass invokedClasses asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := toClass invokedClasses asSet.
			
			size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
			
			(size > normalizationFactor) ifTrue: [ self halt.
				edge := MalWeightedEdge with: targetModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor).
				result add: edge]]].
	
	^result
]

{ #category : #computations }
DependencyAnalysis >> computeCouplingWithNormalizationAndWithoutStubClassesOn [
	
	| classes4screens result commonClasses normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new.
	commonClasses := self identifyCommonClasses reject: #isStub.
	normalizationFactor := commonClasses size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge interestingClasses |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses) reject: [:each | commonClasses includes: each ].   
			
			(interestingClasses size > 0) ifTrue: [
		"		edge := MalWeightedEdge with: aModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor)."
				
				result add: (fromClass -> toClass -> interestingClasses).
				]]].
			
	
	^result
]

{ #category : #computations }
DependencyAnalysis >> computeCouplingWithNormalizationOn [

	| classes4screens result normalizationFactor |

	classes4screens := targetModel allClasses select: [ :each | self class classesForScreens includes: each name asSymbol ].
	result := OrderedCollection new.
	normalizationFactor := self identifyCommonClasses size.
	(1 to: classes4screens size)
		do: [ :rowIndex | 
			| fromClass fromClassInvokingClasses |
			fromClass := classes4screens at: rowIndex.
			fromClassInvokingClasses := fromClass invokedClasses asSet.
			(rowIndex + 1 to: classes4screens size)
				do: [ :colIndex | 
					| toClass toClassInvokingClasses size edge |
					toClass := classes4screens at: colIndex.
					toClassInvokingClasses := toClass invokedClasses asSet.
					size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
					size > normalizationFactor
						ifTrue: [ 
							edge := MalWeightedEdge with: targetModel.
							edge from: fromClass.
							edge to: toClass.
							edge weight: size - normalizationFactor.
							result add: edge ] ] ].
	^ result
]

{ #category : #computations }
DependencyAnalysis >> computeCouplingWithoutNormalizationOn [
	
	| classes4screens result |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		(rowIndex to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
			
			(size > 0) ifTrue: [
				edge := MalWeightedEdge with: targetModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: size.
				result add: edge]]].
	
	^result
]

{ #category : #computations }
DependencyAnalysis >> couplingWithoutNormalizationDetailingInvokersOn [
	
	| classes4screens result |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		(rowIndex to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses invokerClasses edge |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := (toClass invokedClasses reject: #isStub) asSet.
			
			invokerClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses).
			
			(invokerClasses size > 0) ifTrue: [
				edge := MalWeightedEdge with: targetModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: invokerClasses.
				result add: edge]]].
	
	^result
]

{ #category : #view }
DependencyAnalysis >> displayCouplingWithoutNormalizationOn [
	| view edges deps classes4screens |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithoutNormalizationOn.
	
	
	view := MOViewRenderer new.

	view shape rectangle text: #name.  
	view nodes: classes4screens.
	
	"view edges: aModel allInvocations from: [:e| e sender belongsTo ] toAll: [:e| e candidates collect: [:f| f belongsTo ]]. " 
	view shape line width: [:each | each weight ].
	view edges: edges from: #from to: #to.
	
	view circleLayout .
	view open.
]

{ #category : #view }
DependencyAnalysis >> displayDependenciesFrom [
	
	| classes4screens deps view |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	deps := (classes4screens flatCollect: [:e| e withDeepInvokedClasses ]  ) asSet.
	
	view := MOViewRenderer new.

	view shape rectangle text: #name.  
	view nodes: deps.
	
	"view edges: aModel allInvocations from: [:e| e sender belongsTo ] toAll: [:e| e candidates collect: [:f| f belongsTo ]]. "
	view edges: deps from: #yourself toAll: #invokedClasses.
	
	view treeLayout.
	view open.
]

{ #category : #now }
DependencyAnalysis >> entirePOHierarchyButPO [
	"Apparently the classes that are generate from the database table are the one that subclass PO.java and 
	start with 'X_' (for the classes) or 'I_' (for the interface). 
	So this method return all those elements that are contained into the target model"
	
	| relevantClasses relevantInterfaces |

	relevantClasses := (targetModel allClasses select: [:class | class name = 'PO' ]) first subclassHierarchy.
	
	relevantClasses := relevantClasses flatCollect: [:each | each withSuperclassHierarchy].
	
	relevantClasses :=  relevantClasses asSet reject: #isStub.	
	
	relevantClasses remove: ((targetModel allClasses select: [:class | class name = 'PO' ]) first).
	relevantClasses remove: ((targetModel allClasses select: [:class | class name = 'Evaluatee' ]) first).
	
	^relevantClasses 
]

{ #category : #now }
DependencyAnalysis >> entirePOHierarchyWithoutInterfaces [
	"Apparently the classes that are generate from the database table are the one that subclass PO.java and 
	start with 'X_' (for the classes) or 'I_' (for the interface). 
	So this method return all those elements that are contained into the target model"
	
	| relevantClasses relevantInterfaces |

	relevantClasses := (targetModel allClasses select: [:class | class name = 'PO' ]) first subclassHierarchy.
	
	relevantClasses := relevantClasses flatCollect: [:each | each withSuperclassHierarchy].
	
	relevantClasses :=  relevantClasses asSet reject: #isStub.	
	
	relevantClasses remove: ((targetModel allClasses select: [:class | class name = 'PO' ]) first).
	relevantClasses remove: ((targetModel allClasses select: [:class | class name = 'Evaluatee' ]) first).
	relevantClasses := relevantClasses reject: #isInterface.
	
	^relevantClasses 
]

{ #category : #now }
DependencyAnalysis >> exp1TableCoupling [
	| result aStream |
	
	result := self computeCouplingOnTables.
	
	aStream := MultiByteFileStream forceNewFileNamed: 'couplingAmongTables.csv'.
	
	self printTableCouplingFrom: result asCSVOn: aStream.
]

{ #category : #view }
DependencyAnalysis >> exportAllTheHierarchies [
	
	| view |
	
	view := MOViewRenderer new.
	
	self viewAllTheHierarchiesOn: view.
	
	view canvas exportAsPNG.
]

{ #category : #computations }
DependencyAnalysis >> identifyCommonClasses [
	| classes4screens commonClasses |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].

	commonClasses := classes4screens first invokedClasses.

	(2 to: classes4screens size) do: [:index | 
		commonClasses := (classes4screens at: index) invokedClasses intersection: commonClasses].
	
	^commonClasses
	
	
	
]

{ #category : #now }
DependencyAnalysis >> identifyCommonRefereeClassesFor: aCollectionOfClasses [

	| commonClasses |
	
	commonClasses := aCollectionOfClasses first referencingTypes.

	(2 to: aCollectionOfClasses size) do: [:index | 
		commonClasses := (aCollectionOfClasses at: index) referencingTypes asSet intersection: commonClasses].
	
	^commonClasses
	
	
	
]

{ #category : #now }
DependencyAnalysis >> identifyCommonRefereeClassesIn [
	
	| i4sc aModel commonClasses |
	
	i4sc := self interfaces4ScreensIn.
	    

	commonClasses := i4sc first referencingTypes.

	(2 to: i4sc size) do: [:index | 
		commonClasses := (i4sc at: index) referencingTypes asSet intersection: commonClasses].
	
	^commonClasses
	
	
	
]

{ #category : #now }
DependencyAnalysis >> interfaces4ScreensIn [
	^targetModel allTypes select: [:each | self class allInterfacesForScreens includes: each name asSymbol].
	
]

{ #category : #print }
DependencyAnalysis >> print: aCollectionOfWeightedEdges asCSVOn: aStream [
	
	UIManager default
		displayProgress: 'Exporting in CSV'
		at: Sensor cursorPoint
		from: 1 
		to: aCollectionOfWeightedEdges size
		during: [ :bar | 
			| index |
			index := 1.
			aStream nextPutAll: ('Source' , '; ' , 'Target' , '; ' , 'Classes involved the couplig' , '; ' , 'COUPLING VALUE' , String cr).
			aCollectionOfWeightedEdges
				do: [ :edge | 
				
					aStream nextPutAll: edge from name printString , '; ' , edge to name printString , '; ' , edge weight asString , '; ' , edge weight size asString , String cr.
					
					index := index + 1.
					bar value: index. ]].
	aStream close.  
]

{ #category : #print }
DependencyAnalysis >> print: aCollectionOfWeightedEdges asCSVOn: aStream with: aHeader using: aBlock [ 
	
	UIManager default
		displayProgress: 'Exporting in CSV'
		at: Sensor cursorPoint
		from: 1 
		to: aCollectionOfWeightedEdges size
		during: [ :bar | 
			| index |
			index := 1.
			aStream nextPutAll: aHeader.
			aCollectionOfWeightedEdges
				do: [ :edge | 
				
					aStream nextPutAll: (aBlock value: edge).
					
					index := index + 1.
					bar value: index. ]].
	aStream close.  
]

{ #category : #print }
DependencyAnalysis >> print: aCollectionOfWeightedEdges withScreensAsCSVOn: aStream [
	
	UIManager default
		displayProgress: 'Exporting in CSV'
		at: Sensor cursorPoint
		from: 1 
		to: aCollectionOfWeightedEdges size
		during: [ :bar | 
			| index |
			index := 1.
			aStream nextPutAll: ('Screen for Source' , ';' , 'Source' , '; ' , 'Target' , '; ' , 'Screen for Target' , ';' , 'Classes involved the couplig' , '; ' , 'COUPLING VALUE' , String cr).
			aCollectionOfWeightedEdges
				do: [ :edge | 
				
					aStream nextPutAll: (((DependencyAnalysis associationsInterfacesScreens select: [:each | each key = edge from name]) first value) asString , '; ' , edge from printString , '; ' , edge to printString , '; ' , ((DependencyAnalysis associationsInterfacesScreens select: [:each | each key = edge to name]) first value) asString , '; ' , edge weight asString , '; ' , edge weight size asString , String cr).
					
					index := index + 1.
					bar value: index. ]].
	aStream close.  
]

{ #category : #print }
DependencyAnalysis >> printComputeCouplingBasedOnRefereesWithDetailsInTheEdges [
	| interestingClasses edges stream |
	
	
	edges := self computeCouplingBasedOnRefereesWithDetailsInTheEdges asSortedCollection: [:a :b | a weight size > b weight size ].
	stream := MultiByteFileStream forceNewFileNamed: 'resultOfCouplingBasedOnReferees.csv'.
	self print: edges asCSVOn: stream.
]

{ #category : #print }
DependencyAnalysis >> printCouplingWithoutNormalizationDetailingInvokers [
	| edges stream |

	edges := self couplingWithoutNormalizationDetailingInvokersOn asSortedCollection: [:a :b | a weight size > b weight size].
	
	stream := MultiByteFileStream forceNewFileNamed: 'resultOfCouplingWithoutNormalizationDetailingInvokers.csv'.
	self print: edges asCSVOn: stream.
]

{ #category : #print }
DependencyAnalysis >> printDirectConnectionsForAllClasses [
	| edges stream aHeader aBlock allInterestingElements result |
	
	result := OrderedCollection new.
	
	stream  := MultiByteFileStream
		forceNewFileNamed: 'DirectCouplingBetweenAllClasses.csv'.
	aHeader := 'Source' , '; ' , 'Target' ,  ';' , 'Number of connections' , String cr.	
	
	allInterestingElements := (self targetModel allModelClasses reject: #isStub) asOrderedCollection.
 
	aBlock := [:edge | edge from name printString , '; ' , edge to name printString , '; ' , edge weight asString , String cr].	
	
	 (1 to: allInterestingElements size) do: [:index |
		| type referedTypes counter |
		counter := Dictionary new.
		type := allInterestingElements at: index.
		referedTypes := (allInterestingElements at: index) referedTypes reject: [:each | each isMemberOf: FAMIXPrimitiveType].
		referedTypes do: [:referedType | counter at: referedType ifPresent: [:value | counter at: referedType put: value + 1] ifAbsent: [counter at: referedType put: 1] ].
		
		counter keysAndValuesDo: [:key :value |
			| edge |
			edge := MalWeightedEdge with: targetModel.
			edge from: type.
			edge to: key.
			edge weight: value.
			
			result add: edge] ].
	
	self
		print: result
		asCSVOn: stream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printDirectConnectionsForAllClassesWithDetails [
	| result stream aHeader allInterestingElements aBlock |

	result := OrderedCollection new.
	
	stream  := MultiByteFileStream
		forceNewFileNamed: 'DirectCouplingBetweenAllClassesWithDetails.csv'.
	aHeader := 'Source' , '; ' , 'Target' ,  ';' , 'Number of connections' , ';' , 'Method invokations' , ';' , 'Methods Returned type' , ';' , 'Accesses' , String cr.	
	
	allInterestingElements := (self targetModel allModelClasses reject: #isStub) asOrderedCollection.
 
	aBlock := [:entry |
			(entry at: 'from') printName , '; ' , 
			(entry at: 'to') printName , '; ' , 
			(entry at: 'numberOfConnections') asString , ';' ,
			((entry at: 'methodInvocations') inject: '' into: [:total :subtotal | total , subtotal asString , ' ']) asString , ';' , 
			((entry at: 'methodReturningSomething') inject: '' into: [:total :subtotal | total , subtotal asString , ' ']) asString , ';' , 
			((entry at: 'accessedVariables') inject: '' into: [:total :subtotal | total , subtotal asString , ' ']) asString ,		
			String cr].	
	
	 (1 to: allInterestingElements size) do: [:index |
		| type referedTypes methodsReturningSomething accessedVariables methodInvocations counter parityCheck |

		type := allInterestingElements at: index.
		counter := Dictionary new.
		
		methodsReturningSomething := type methodWithReturnType.
		accessedVariables := type notNilAccesses. "self accessor asString , ' -> ' , self variable asString"
		methodInvocations := type outgoingInvocations reject: [:invocation | (((invocation candidates collect: #belongsTo) reject: #isStub) reject: [:each | each isMemberOf: FAMIXPrimitiveType]) isEmpty ].	

		referedTypes := ((type referedTypes reject: [:each | each isMemberOf: FAMIXPrimitiveType]) reject: [:each | each = type]) reject: #isStub.
		referedTypes do: [:referedType | counter at: referedType ifPresent: [:value | counter at: referedType put: value + 1] ifAbsent: [counter at: referedType put: 1] ].
		parityCheck := 0.
		
		referedTypes asSet do: [:referedType |
			| entry |
			entry := Dictionary new.

			entry at: 'from'	put: type.
			entry at: 'to' put: referedType.

			entry at: 'methodInvocations' put: (methodInvocations reject: [:invocation | (invocation candidates select: [:candidate | candidate belongsTo = referedType]) isEmpty]).
			entry at: 'methodReturningSomething' put: (methodsReturningSomething select: [:method | method declaredType = referedType]).
			
			entry at: 'accessedVariables' put: (accessedVariables select: [:access | access variable belongsTo = referedType]).
			(entry at: 'accessedVariables') addAll: ((accessedVariables select: [:each | each variable belongsTo isMemberOf: FAMIXMethod]) select: [:each | each variable belongsTo belongsTo = referedType]).
	
			entry at: 'numberOfConnections' put: ((entry at: 'methodInvocations') size + (entry at: 'methodReturningSomething') size + (entry at: 'accessedVariables') size).
			
			parityCheck := parityCheck + (entry at: 'numberOfConnections').
			
			entry at: 'parityCheck' put: parityCheck.
			
			result add: entry ].

		(referedTypes size = parityCheck) ifFalse: [self halt.].
	 ].

	self
		print: result
		asCSVOn: stream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printDirectConnectionsForAllInterestingClasses [
	| edges stream aHeader aBlock allInterestingElements result |
	
	result := OrderedCollection new.
	
	stream  := MultiByteFileStream
		forceNewFileNamed: 'CouplingBasedOnAllSystemWithSubclasses.csv'.
	
	stream  := MultiByteFileStream
		forceNewFileNamed: 'DirectCouplingBetweenInterestingClasses.csv'.
	aHeader := 'Source' , '; ' , 'Target' ,  ';' , 'Number of connections' , String cr.	
	
	allInterestingElements := self allInterestingElementInTheTargetModel asOrderedCollection reject: [:each | each isMemberOf: FAMIXPrimitiveType].
	
	aBlock := [:edge | edge from name printString , '; ' , edge to name printString , '; ' , edge weight asString , String cr].	
	
	 (1 to: allInterestingElements size) do: [:index |
		| type referedTypes counter |
		counter := Dictionary new.
		type := allInterestingElements at: index.
		referedTypes := (allInterestingElements at: index) referedTypes reject: [:each | each isMemberOf: FAMIXPrimitiveType].
		referedTypes do: [:referedType | counter at: referedType ifPresent: [:value | counter at: referedType put: value + 1] ifAbsent: [counter at: referedType put: 1] ].
		
		counter keysAndValuesDo: [:key :value |
			| edge |
			edge := MalWeightedEdge with: targetModel.
			edge from: type.
			edge to: key.
			edge weight: value.
			
			result add: edge] ].
	
	self
		print: result
		asCSVOn: stream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printGeneratedClassesWithSubclasses [
	| aStream aHeader aBlock aCollection rootClasses fileName |
	
	aCollection := self entirePOHierarchyButPO asMooseGroup.
	fileName := 'generatedClassesWithSubclasses.csv'.
	
	rootClasses := (aCollection select: [ :each | each isHierarchyRootWithin: aCollection ]) sorted: [ :a :b | a name < b name ].
	aStream := MultiByteFileStream forceNewFileNamed: (FileDirectory default pathName , FileDirectory pathNameDelimiter asString , 'output' , FileDirectory pathNameDelimiter asString , fileName).
	aHeader := 'Type' , ';' , 'Subclasses' , String cr.
	aBlock := [ :type | 
		type printName , (type isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) , ';' ,
		((type subclassHierarchy reject: #isStub) asSet inject: '' into: [ :total :subtotal | total , subtotal printName , (subtotal isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) ]) , ';' ,
		String cr ].
	
	self
		print: rootClasses
		asCSVOn: aStream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printGeneratedClassesWithSubclassesWithoutInterfaces [
	| aStream aHeader aBlock aCollection rootClasses fileName |
	
	aCollection := self entirePOHierarchyWithoutInterfaces asMooseGroup.
	fileName := 'generatedClassesWithSubclassesWithoutInterfaces.csv'.
	
	rootClasses := (aCollection select: [ :each | each isHierarchyRootWithin: aCollection]) sorted: [ :a :b | a name < b name ].
	aStream := MultiByteFileStream forceNewFileNamed: (FileDirectory default pathName , FileDirectory pathNameDelimiter asString , 'output' , FileDirectory pathNameDelimiter asString , fileName).
	aHeader := 'Type' , ';' , 'Subclasses' , String cr.
	aBlock := [ :type | 
		type printName , (type isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) , ';' ,
		((type subclassHierarchy reject: #isStub) asSet inject: '' into: [ :total :subtotal | total , subtotal printName , (subtotal isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) ]) , ';' ,
		String cr ].
	
	self
		print: rootClasses 
		asCSVOn: aStream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printGeneratedClassesWithSubclassesWithoutXClasses [
	| aStream aHeader aBlock aCollection rootClasses fileName |
	
	aCollection := self entirePOHierarchyButPO asMooseGroup.
	fileName := 'generatedClassesWithSubclassesWithoutXClasses.csv'.
	
	rootClasses := (aCollection select: [ :each | each isHierarchyRootWithin: aCollection]) sorted: [ :a :b | a name < b name ].
	aStream := MultiByteFileStream forceNewFileNamed: (FileDirectory default pathName , FileDirectory pathNameDelimiter asString , 'output' , FileDirectory pathNameDelimiter asString , fileName).
	aHeader := 'Type' , ';' , 'Subclasses' , String cr.
	aBlock := [ :type | 
		type printName , (type isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) , ';' ,
		((type subclassHierarchy reject: #isStub) asSet inject: '' into: [ :total :subtotal | total , subtotal printName , (subtotal isInterface ifFalse:[' (Class) '] ifTrue:[' (Interface) ']) ]) , ';' ,
		String cr ].
	
	self
		print: rootClasses 
		asCSVOn: aStream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesIn [
	| view edges deps |
	edges := self computeCouplingBasedOnRefereesWDIn asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , ', ', e to printString , ', ', e weight asString ; cr.
		] .
	
	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDAndEdges [
	| edges stream |
	edges := self computeCouplingBasedOnRefereesWDAndEdges asSortedCollection: [:a :b | a weight size > b weight size].
	
	stream := MultiByteFileStream forceNewFileNamed: 'couplingBasedOnRefereesWDAndEdges.csv'.
	
	self print: edges asCSVOn: stream.
	

	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDAndEdgesOnAllSystem [
	| edges stream |
	edges := self computeCouplingBasedOnRefereesWDAndEdgesOnAllSystem asSortedCollection: [:a :b | a weight size > b weight size].
	
	stream := MultiByteFileStream forceNewFileNamed: 'couplingBasedOnRefereesWDAndEdgesOnAllSystem.csv'.
	
	self print: edges asCSVOn: stream.
	

	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDAndEdgesOnAllSystemWithSubclasses [
	| edges stream aHeader aBlock |

	edges := self computeCouplingBasedOnRefereesWDAndEdgesOnAllSystem
		asSortedCollection: [ :a :b | a weight size > b weight size ].

	stream := MultiByteFileStream
		forceNewFileNamed: 'CouplingBasedOnAllSystemWithSubclasses.csv'.
	
	aHeader := 'Source' , '; ' , 'Source Subclasses' , '; ' ,'Target' , '; ' , 'Target Subclasses' , '; ' , 'Classes involved in the couplig' , '; ' , 'COUPLING VALUE' , String cr.
	
	aBlock := [ :edge | 
		edge from name , '; ' ,
		(edge from subclassHierarchy inject: '' into: [:total :subtotal | total , subtotal name , ' (Class) ']) asString , ';' , 
		edge to name , '; ' ,
		(edge to subclassHierarchy inject: '' into: [:total :subtotal | total , subtotal name , ' (Class) ']) asString , ';' , 
		(edge weight inject: '' into: [:total :subtotal | total , subtotal name , ' (Class) ']) asString , ';' ,
		edge weight size asString , 
		String cr ].
	
	self
		print: edges
		asCSVOn: stream
		with: aHeader
		using: aBlock
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDAndEdgesWithScreens [
	| edges stream |
	edges := self computeCouplingBasedOnRefereesWDAndEdges asSortedCollection: [:a :b | a weight size > b weight size].
	
	stream := MultiByteFileStream forceNewFileNamed: 'couplingBasedOnRefereesWDAndEdgesWithScreens.csv'.
	
	self print: edges withScreensAsCSVOn: stream.
	

	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDIn [
	| view edges deps |
	edges := self computeCouplingBasedOnRefereesWDIn asSortedCollection: [:a :b | a value size > b value size].
	Transcript clear.
	(edges copyFrom: 1 to: 20) do: [:e |
		Transcript show: e key key printString , '; ', e key value printString;cr; show: '; (', e value name, ')' ; cr.
		] .
	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingWithNormalizationWithoutStubsOn [
	| view edges deps classes4screens |
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithNormalizationAndWithoutStubClassesOn asSortedCollection: [:a :b | a value size >b value size].
	Transcript clear.
	(edges copyFrom:1 to: 40) do: [:e|
		Transcript show: e key key printString , '; ', e key value printString;cr; show: '; (', e value name, ')' ; cr.
		] .
	
	
]

{ #category : #print }
DependencyAnalysis >> printSortedCouplingWithoutNormalizationOn [
	| view edges deps classes4screens |
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithoutNormalizationOn asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , '; ', e to printString , '; ', e weight asString ; cr.
		] .
	
	
]

{ #category : #print }
DependencyAnalysis >> printTableCouplingFrom: aCollectionOfWeightedEdges asCSVOn: aStream [
	
	UIManager default
		displayProgress: 'Exporting in CSV'
		at: Sensor cursorPoint
		from: 1 
		to: aCollectionOfWeightedEdges size
		during: [ :bar | 
			| index |
			index := 1.
			aStream nextPutAll: ('TABLE 1' , '; ' , 'TABLE 2' , '; ' , 'SHARED TABLES' , '; ' , 'SHARED TABLE NUMBER' , String cr).
			aCollectionOfWeightedEdges
				do: [ :edge | 				
					aStream nextPutAll: (edge from name , ' ; ' , edge to name , ' ; ' , edge weight asString , ' ; ' , edge weight size asString , String cr).					
					index := index + 1.
					bar value: index. ]].
	aStream close.  
]

{ #category : #accessing }
DependencyAnalysis >> targetModel [
	^targetModel
]

{ #category : #accessing }
DependencyAnalysis >> targetModel: aModel [
	targetModel := aModel   
]

{ #category : #view }
DependencyAnalysis >> viewAllTheHierarchies [
	
	| view |
	view := MOViewRenderer new.
	
	self viewAllTheHierarchiesOn: view.
	
	view open.
]

{ #category : #view }
DependencyAnalysis >> viewAllTheHierarchiesOn: view [
	
	| po allSubClasses rootClasses lonelyRootClasses allSubClassesNotLonely |
	
	po := targetModel allTypes select: [:each | each name = 'PO'].
	
	(po size = 1) ifFalse: [
		UIManager default alert: 'More than one PO has been found'.
		^self].
	po := po first.
	
	allSubClasses := po subclassHierarchyGroup.
	
	rootClasses := allSubClasses select: [:each | each isHierarchyRootWithin: allSubClasses].
	lonelyRootClasses := rootClasses select: [:each | each isLonelyWithin: allSubClasses].
	rootClasses := rootClasses difference: lonelyRootClasses.

	
	rootClasses notEmpty ifTrue: [
		view shape rectangle withoutBorder; withoutBackground.
		view node: 'rootClasses' forIt: [
			(rootClasses asSortedCollection: [:a :b | a name < b name]) do: [:root | 
				view shape rectangle text: #name.
				view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
				view nodes: root withSubclassHierarchyGroup.
				
				view edgesFrom: #superclass.
				view treeLayout.
			].
		].
	].

	lonelyRootClasses notEmpty ifTrue: [
		view shape rectangle withoutBorder; withoutBackground.
		view node: 'lonelyRootClasses' forIt: [
			view shape rectangle text: #name.  
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view nodes: (lonelyRootClasses asSortedCollection: [:a :b | a name < b name]).
			
			view flowLayout maxWidth: 300; gapSize: 2.
		].
	].

]
