Class {
	#name : #MJFAMIXSessionBeanGroup,
	#superclass : #MEEAbstractGroup,
	#category : #'Moose-JEE-EJB-Model'
}

{ #category : #meta }
MJFAMIXSessionBeanGroup class >> annotation [

	<MSEClass: #MJFAMIXSessionBeanGroup super: #MEEAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewApplicationByLayers [
	"<menuItem: 'Application by Layers' category: 'JEAs Visualizations'>"

	| invoked view beans data logic map invocationsMap  allModelClasse |

	view := ROMondrianViewBuilder new.
	beans := self collect: #implementationClass.
	allModelClasse := beans first mooseModel allClasses.
	invoked := (beans flatCollect: #withDeepInvokedClasses) asSet asOrderedCollection reject: [:each | beans includes: each].
	data := invoked select: #isADataLayerClass.
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
			view shape rectangle withBorder.
			view node: 'Service Layer Content' forIt:[
					view interaction nodraggable.
					view nodes: beans using: [view shape rectangle 
															width: #numberOfAttributes; 
															height: #numberOfMethods; 
															linearFillColor: #numberOfLinesOfCode within:  allModelClasse; 
															withBorder ] ] ].

	view open. 
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'JEAs Visualizations'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.

]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewLayerOn: view [
	
	view shape umlClass.
	view interaction popupText.
	view nodes: self entities.
	view shape: ROOrthoVerticalLineShape new.
	view edgesFrom: #superclass.
	view treeLayout
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewLayers [
	"<menuItem: 'Layers' category: 'JEAs Visualizations'>"

	| invoked view beans data logic map |
	view := ROMondrianViewBuilder new.
	beans := self collect: #implementationClass.
	invoked := (beans flatCollect: #withDeepInvokedClasses) asSet asOrderedCollection reject: [:each | beans includes: each].
	data := invoked select: #isADataLayerClass.
	logic := invoked reject: #isADataLayerClass.
	
	map := IdentityDictionary new.
	data do: [:each | map at: each mooseName put: 3].
	logic do: [:each | map at: each mooseName put: 2].
	beans do: [:each | map at: each mooseName put: 1].

	"view shape: (view shape rectangle withText: 'Service Layer')."
	view node: beans forIt: [
		view nodes: beans using: ( view shape rectangle width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view horizontalLineLayout.
	].
	view shape: (view shape rectangle withText: 'Logic Layer').
	view node: #logic forIt: [
		view nodeShape: ( view shape rectangle width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view nodes: logic.
		view dominanceTreeLayout.
	].
	"view  shape rectangle withText: 'Data Layer'."
	view shape: (view shape rectangle withText: 'Data Layer').
	view node: #data forIt: [
		view nodeShape: ( view shape rectangle width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view nodes: data.
		view dominanceTreeLayout.
	].
	
	view shape curvedLine
		color: [:assoc | 
		(map at: assoc key mooseName) = (map at: assoc value mooseName) 
			ifTrue: [Color white] 
			ifFalse: [	((map at: assoc key mooseName) - (map at: assoc value mooseName)) abs < 2 ifTrue: [Color blue] ifFalse: [Color orange]]
	].

	view open
]
