Class {
	#name : #MJFAMIXSessionBeanGroup,
	#superclass : #MooseGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup class >> annotation [

	<MSEClass: #SessionBeanGroup super: #MooseGroup>
	<package: #FAMIX>

]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> umlLikeShape: aString on: aBlock [

	| builder |

	builder := MOFormsBuilder new.
	builder column; fill.
	builder row; fill; row; fill.
	builder x: 1 y: 1 add: MORectangleShape new.
	builder x: 1 y: 1 add: (MOLabelShape new text: aString).
	builder x: 1 y: 2 add: MORectangleShape new.
	builder x: 1 y: 2 add: aBlock.
	^builder shape
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> umlShape: aString [

	| builder |

	builder := MOFormsBuilder new.
	builder
		column;
		fill.
	builder
		row;
		fill;
		row;
		fill.
	builder 
		x: 1
		y: 1
		add: MORectangleShape new.
	builder 
		x: 1
		y: 1
		add: (MOLabelShape new text: [:cls | aString]).
	builder 
		x: 1
		y: 2
		add: MORectangleShape new.
	builder 
		x: 1
		y: 2
		add: (MOLabelShape new text: 
			[ :cls | 
			cls methodDict keys 
				inject: ''
				into: [ :sum :el | sum , el , String cr ] ]).
	^ builder shape

]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> umlShape: aString with: aCollection [
	| builder |
	builder := MOFormsBuilder new.
	builder
		column;
		fill.
	builder
		row;
		fill;
		row;
		fill.
	builder 
		x: 1
		y: 1
		add: (MOLabelShape new text: aString).
	builder 
		x: 1
		y: 2
		add: MORectangleShape new.
	builder 
		x: 1
		y: 2
		add: (self nodes: aCollection using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: aCollection first mooseModel allClasses; withBorder )).
	^ builder shape
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> umlShape: aString with: aCollection on: aView [
	| builder |
	builder := MOFormsBuilder new.
	builder
		column;
		fill.
	builder
		row;
		fill;
		row;
		fill.
	builder 
		x: 1
		y: 1
		add: MORectangleShape new.
	builder 
		x: 1
		y: 1
		add: (MOLabelShape new text: aString).
	builder 
		x: 1
		y: 2
		add: MORectangleShape new.
	builder 
		x: 1
		y: 2
		add: (aView nodes: aCollection using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: aCollection first mooseModel allClasses; withBorder )).
	^ builder shape
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewApplicationByLayers [
	<menuItem: 'Application by Layers' category: 'Mondrian'>

	| invoked view beans data logic map invocationsMap layerShape aBlock  myShape |
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
	
	"view shape a: (MORectangleShape new withBorder) withNameOnTop: 'Service Layer'."
"	using: (view shape a: (MORectangleShape new withBorder) withNameOnTop: 'Service Layer') "
	
	myShape := MORectangleShape new withBorder.
	"view shape a: myShape withNameOnTop: 'Service Layer'."
	"view node: #Service."
	view 
		node: #Service
		using: myShape "(myShape builder components third component)"
		forIt: [view nodes: beans using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).].
	view shape a: myShape withNameOnTop: 'Service Layer'.
	view node:#prova.
"	view node: #Service using: (view shape a: (view shape rectangle withBorder) withNameOnTop: 'Service Layer') forIt: [view nodes: beans using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).]."

			
	"view shape a: (view shape rectangle withBorder) withNameOnTop: 'Service Layer'.
	view 
		node: #Service 
		forIt: [view nodes: beans using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).].

	view dominanceTreeLayout.
	"
	
	"view shape a: ([view shape rectangle withBorder.
	view node: #data forIt: [
				view nodes: data using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view dominanceTreeLayout ].] )withNameOnTop: 'Data Layer'.
	"
	
	"view shape layerCalled: 'Service Layer' on: beans.
	view node: beans.
	view dominanceTreeLayout."
	
	"view umlPackageShapeWithLabel: 'Data Layer'."
	"view shape: (self umlShape: 'Data Layer').
	view node: #data forIt: [
		view nodeShape: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view nodes: data.
		view dominanceTreeLayout.
	].
	
	view shape curvedLine
		color: [:assoc | 
		(map at: assoc key mooseName) = (map at: assoc value mooseName) 
			ifTrue: [Color white] 
			ifFalse: [	((map at: assoc key mooseName) - (map at: assoc value mooseName)) abs < 2 ifTrue: [Color blue] ifFalse: [Color orange]]
	].
	view edges: invocationsMap from: #key to: #value.
	view edges: beans first mooseModel allClasses from: #superclass to: #yourself.
	view verticalLineLayout verticalGap: 40."
	view open
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewAsSelectionOnSystemComplexity [

	<menuItem: 'As selection on System Complexity' category: 'Mondrian'>

	(FAMIXClassGroup withAll: (self collect: #implementationClass)) viewAsSelectionOnSystemComplexity.

]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewLayerOn: view [
	
	view shape umlClass.
	view interaction popupText.
	view nodes: self entities.
	view shape: MOOrthoVerticalLineShape new.
	view edgesFrom: #superclass.
	view treeLayout
]

{ #category : #'as yet unclassified' }
MJFAMIXSessionBeanGroup >> viewLayers [
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

	"view shape: (view umlShape: 'Service Layer')."
	view node: beans forIt: [
		view nodes: beans using: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view horizontalLineLayout.
		self halt.
	].
	view shape: (view umlShape: 'Logic Layer').
	view node: #logic forIt: [
		view nodeShape: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view nodes: logic.
		view dominanceTreeLayout.
	].
	"view umlPackageShapeWithLabel: 'Data Layer'."
	view shape: (self umlShape: 'Data Layer').
	view node: #data forIt: [
		view nodeShape: ( MORectangleShape new width: #numberOfAttributes; height: #numberOfMethods; linearFillColor: #numberOfLinesOfCode within: beans first mooseModel allClasses; withBorder ).
		view nodes: data.
		view dominanceTreeLayout.
	].
	
	view shape curvedLine
		color: [:assoc | 
		(map at: assoc key mooseName) = (map at: assoc value mooseName) 
			ifTrue: [Color white] 
			ifFalse: [	((map at: assoc key mooseName) - (map at: assoc value mooseName)) abs < 2 ifTrue: [Color blue] ifFalse: [Color orange]]
	].
	"view edges: invocationsMap from: #key to: #value.
	view edges: beans first mooseModel allClasses from: #superclass to: #yourself.
	view verticalLineLayout verticalGap: 40."
	view open
]
