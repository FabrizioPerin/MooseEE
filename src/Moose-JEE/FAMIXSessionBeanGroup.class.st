Class {
	#name : #FAMIXSessionBeanGroup,
	#superclass : #MooseGroup,
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXSessionBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'Mondrian'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.
]

{ #category : #'as yet unclassified' }
FAMIXSessionBeanGroup >> viewLayers [
	<menuItem: 'Layers' category: 'Mondrian'>

	| invoked view beans data logic map invocationsMap |
	view := MOViewRenderer new.
	beans := self collect: #implementationClass.
	invoked := (beans flatCollect: #withDeepInvokedClasses) asSet asOrderedCollection reject: [:each | beans includes: each].
	data := invoked select: #isADataLayerClass.
	logic := invoked reject: #isADataLayerClass.
	
	map := IdentityDictionary new.
	data do: [:each | map at: each mooseName put: 3].
	logic do: [:each | map at: each mooseName put: 2].
	beans do: [:each | map at: each mooseName put: 1].

	invocationsMap := beans first mooseModel allClasses flatCollect: [:each | each invokedClasses collect: [:x | each -> x]]. 

	view umlPackageShapeWithLabel: 'Service Layer'.
	view node: beans forIt: [
		view newShape rectangle; height: #numberOfMethods; width: #numberOfAttributes; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel referenceClasses; withBorder.
		view nodes: beans.
		view horizontalLineLayout.
	].
	view umlPackageShapeWithLabel: 'Logic Layer'.
	view node: #logic forIt: [
		view newShape rectangle; height: #numberOfMethods; width: #numberOfAttributes; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel referenceClasses; withBorder.
		view nodes: logic.
		view dominanceTreeLayout.
	].
	view umlPackageShapeWithLabel: 'Data Layer'.
	view node: #data forIt: [
		view newShape rectangle; height: #numberOfMethods; width: #numberOfAttributes; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel referenceClasses; withBorder.
		view nodes: data.
		view dominanceTreeLayout.
	].
	
	view newShape curvedLine; lineColor: [:assoc | 
		(map at: assoc key mooseName) = (map at: assoc value mooseName) 
			ifTrue: [Color white] 
			ifFalse: [	((map at: assoc key mooseName) - (map at: assoc value mooseName)) abs < 2 ifTrue: [Color blue] ifFalse: [Color orange]]
	].
	view edges: invocationsMap from: #key to: #value.
	view edges: beans first mooseModel allClasses from: #superclass to: #yourself.
	view verticalLineLayout verticalGap: 40.
	view open
]
