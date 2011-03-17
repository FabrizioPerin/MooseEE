Class {
	#name : #DependencyAnalysis,
	#superclass : #Object,
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
DependencyAnalysis >> computeCouplingWithNormalizationAndWithStubClassesOn: aModel [
	| classes4screens deps view result normalizationFactor |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	normalizationFactor := (self identifyCommonClassesOn: aModel) size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := (fromClass invokedClasses reject: #isStub) asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := toClass invokedClasses asSet.
			
			size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
			
			(size > normalizationFactor) ifTrue: [ self halt.
				edge := MalWeightedEdge with: aModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor).
				result add: edge]]].
	
	^result
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> computeCouplingWithNormalizationOn: aModel [
	| classes4screens deps view result normalizationFactor |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	result := OrderedCollection new. 
	normalizationFactor := (self identifyCommonClassesOn: aModel) size.  
	
	(1 to: classes4screens size) do: [:rowIndex |
		| fromClass fromClassInvokingClasses |
		fromClass := classes4screens at: rowIndex.
		fromClassInvokingClasses := fromClass invokedClasses asSet.
		
		((rowIndex +1) to: classes4screens size) do: [:colIndex |
			| toClass toClassInvokingClasses size edge |
			toClass := classes4screens at: colIndex.
			toClassInvokingClasses := toClass invokedClasses asSet.
			
			size := (fromClassInvokingClasses intersection: toClassInvokingClasses) size.
			
			(size > normalizationFactor) ifTrue: [
				edge := MalWeightedEdge with: aModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: (size - normalizationFactor).
				result add: edge]]].
	
	^result
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> computeCouplingWithoutNormalizationOn: aModel [
	| classes4screens deps view result normalizationFactor |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
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
				edge := MalWeightedEdge with: aModel.
				edge from: fromClass.
				edge to: toClass.
				edge weight: size.
				result add: edge]]].
	
	^result
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> displayCouplingOn: aModel [
	| view edges deps classes4screens |
	
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingOn: aModel.
	
	
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
DependencyAnalysis >> displayCouplingWithoutNormalizationOn: aModel [
	| view edges deps classes4screens |
	
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := self computeCouplingWithoutNormalizationOn: aModel.
	
	
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
DependencyAnalysis >> displayDependenciesFrom: aModel [
	| classes4screens deps view |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
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
DependencyAnalysis >> identifyCommonClassesOn: aModel [
	| classes4screens commonClasses |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].

	commonClasses := classes4screens first invokedClasses.

	(2 to: classes4screens size) do: [:index | 
		commonClasses := (classes4screens at: index) invokedClasses intersection: commonClasses].
	
	^commonClasses
	
	
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> printSortedCouplingOn: aModel [
	| view edges deps classes4screens |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := (self computeCouplingOn: aModel) asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , ', ', e to printString , ', ', e weight asString ; cr.
		] .
	
	
]

{ #category : #'as yet unclassified' }
DependencyAnalysis >> printSortedCouplingWithoutNormalizationOn: aModel [
	| view edges deps classes4screens |
	classes4screens := aModel allClasses select: [:each | self class classesForScreens includes: each name asSymbol].
	edges := (self computeCouplingWithoutNormalizationOn:    aModel) asSortedCollection: [:a :b | a weight >b weight].
	Transcript clear.
	edges do: [:e|
		Transcript show: e from printString , '; ', e to printString , '; ', e weight asString ; cr.
		] .
	
	
]
