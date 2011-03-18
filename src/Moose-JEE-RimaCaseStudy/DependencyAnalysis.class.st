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
DependencyAnalysis >> computeCouplingBasedOnRefereesIn [
	
	| interf4scr result normalizationFactor |
	
	interf4scr := self interfaces4ScreensIn.  
	result := OrderedCollection new. 
	normalizationFactor := self identifyCommonRefereeClassesIn size.  
	
	(1 to: interf4scr size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := interf4scr at: rowIndex.
		fromClassInvokingClasses := fromClass referencingTypes asSet.
		
		((rowIndex +1) to: interf4scr size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge |
			toClass := interf4scr at: colIndex.
			toClassInvokingClasses := toClass referencingTypes asSet.
			
			size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
			
			(size > normalizationFactor) ifTrue: [
				edge := MalWeightedEdge with: targetModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor).
				result add: edge]
			]].
	
	^result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWDIn [
	| interf4scr deps view result commonTypes |
	interf4scr := self interfaces4ScreensIn.  
	result := OrderedCollection new. 
	commonTypes := self identifyCommonRefereeClassesIn.
	
	(1 to: interf4scr size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := interf4scr at: rowIndex.
		fromClassInvokingClasses := fromClass referencingTypes asSet.
		
		((rowIndex +1) to: interf4scr size) do: [:colIndex |
			| toClass toClassInvokingClasses edge interestingClasses |
			toClass := interf4scr at: colIndex.
			toClassInvokingClasses := toClass referencingTypes asSet.
			
			interestingClasses := (fromClassInvokingClasses intersection: toClassInvokingClasses) reject: [:each | commonTypes includes: each ].
			
			(interestingClasses size > 0) ifTrue: [
				result add: (fromClass -> toClass -> interestingClasses).
				]
			]].
	
	^result
]

{ #category : #now }
DependencyAnalysis >> computeCouplingBasedOnRefereesWithDetails [

	| classes4screens result commonClasses normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new.
	commonClasses := self identifyCommonClassesOn reject: #isStub.
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DependencyAnalysis >> computeCouplingWithNormalizationAndWithStubClassesOn [
	| classes4screens result normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	normalizationFactor := self identifyCommonClassesOn size.  
	
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

{ #category : #'as yet unclassified' }
DependencyAnalysis >> computeCouplingWithNormalizationAndWithoutStubClassesOn [
	
	| classes4screens result commonClasses normalizationFactor |
	
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new.
	commonClasses := self identifyCommonClassesOn reject: #isStub.
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

{ #category : #'as yet unclassified' }
DependencyAnalysis >> computeCouplingWithNormalizationOn [

	| classes4screens result normalizationFactor |

	classes4screens := targetModel allClasses select: [ :each | self class classesForScreens includes: each name asSymbol ].
	result := OrderedCollection new.
	normalizationFactor := self identifyCommonClassesOn size.
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DependencyAnalysis >> identifyCommonClassesOn [
	| classes4screens aModel commonClasses |
	
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].

	commonClasses := classes4screens first invokedClasses.

	(2 to: classes4screens size) do: [:index | 
		commonClasses := (classes4screens at: index) invokedClasses intersection: commonClasses].
	
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

{ #category : #now }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesIn [
	| view edges deps |
	edges := self computeCouplingBasedOnRefereesWDIn asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , ', ', e to printString , ', ', e weight asString ; cr.
		] .
	
	
]

{ #category : #now }
DependencyAnalysis >> printSortedCouplingBasedOnRefereesWDIn [
	| view edges deps |
	edges := self computeCouplingBasedOnRefereesWDIn asSortedCollection: [:a :b | a value size > b value size].
	Transcript clear.
	(edges copyFrom: 1 to: 20) do: [:e |
		Transcript show: e key key printString , '; ', e key value printString;cr; show: '; (', e value name, ')' ; cr.
		] .
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> printSortedCouplingOn [
	| view edges deps classes4screens |
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingOn asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , ', ', e to printString , ', ', e weight asString ; cr.
		] .
	
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> printSortedCouplingWithNormalizationWithoutStubsOn [
	| view edges deps classes4screens |
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithNormalizationAndWithoutStubClassesOn asSortedCollection: [:a :b | a value size >b value size].
	Transcript clear.
	(edges copyFrom:1 to: 40) do: [:e|
		Transcript show: e key key printString , '; ', e key value printString;cr; show: '; (', e value name, ')' ; cr.
		] .
	
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> printSortedCouplingWithoutNormalizationOn [
	| view edges deps classes4screens |
	classes4screens := targetModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithoutNormalizationOn asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , '; ', e to printString , '; ', e weight asString ; cr.
		] .
	
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> targetModel [
	^targetModel
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> targetModel: aModel [
	targetModel := aModel   
]
