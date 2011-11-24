Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> add: anElement [ 
	 
	super add: anElement. 
	anElement privateSetMooseModel: self.
	"self announcer announce: (MooseEntityAdded new entity: anElement)."
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> allDerivedDependencies [

	^self allWithType: MJFAMIXDerivedDependency "asMetaDescription"
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> cleanUpDuplicatedDeriveDependencies [
	<menuItem: 'Clean up duplicated derived dependencies' category: 'JEAs Utilities'>
	
	| dd toRemove|
	
	dd := self allDerivedDependencies.
	toRemove := OrderedCollection new.
	(1 to: dd size) do: [:firstDDIndex |
		((firstDDIndex + 1) to: dd size) do: [:secondDDIndex |
			((dd at: firstDDIndex) source = (dd at: secondDDIndex) source) ifTrue: [
				((dd at: firstDDIndex) target = (dd at: secondDDIndex) target) ifTrue: [
					((dd at: firstDDIndex) isDirected = (dd at: secondDDIndex) isDirected) ifTrue: [
						((dd at: firstDDIndex) rationale = (dd at: secondDDIndex) rationale) ifTrue: [
							toRemove add: (dd at: secondDDIndex) ]]]]]].
	
	self silentlyRemoveAll: toRemove asSet.  
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> fixFileAnchorsFrom: aFolder [ 
	| index startingPoint javaFiles |

	self rootFolder: aFolder pathName.
	self name: aFolder localName.
	index := 1.
	
	javaFiles := OrderedCollection new.
	startingPoint := aFolder entries asOrderedCollection.
	
	startingPoint do: [:each | 
		each isDirectory 
			ifFalse: [('.*\.java$' asRegex matches: each name) ifTrue: [javaFiles add: each]]
			ifTrue: [startingPoint addAll: each asFileDirectory entries]].
	
	UIManager default
		displayProgress: 'Fixing'
		at: Sensor cursorPoint
		from: index
		to: self allClasses size * javaFiles size
		during: [:bar | 
			bar value: index.

			self allClasses
				do: [:class | 
					javaFiles do: [:file |
						(class name , '.java' = file name) ifTrue: [
							"| fileStream |
							fileStream := CrLfFileStream new open: file fullName forWrite: false."
							class sourceAnchor fileName: (file fullName copyFrom: (self rootFolder size + 1) to: file fullName size)].
						index := index + 1.
						bar value: index]]]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> fixFileAnchorsFromGUI [
	| aFolder |
	<menuItem: 'Try to fix file anchors' category: 'JEAs Utilities'>
	aFolder := UITheme builder chooseDirectory: 'Choose the root folder for ' , self name.
	aFolder isNil
		ifTrue: [DialogWindow new alert: 'Folder not found.']
		ifFalse: [self fixFileAnchorsFrom: aFolder]
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> silentlyAdd: anElement [ 
	 
	super add: anElement. 
	anElement privateSetMooseModel: self.
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> silentlyAddAll: entities [ 
	 
	entities do: [:each | self silentlyAdd: each].
	^entities
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> silentlyRemove: anElement [ 
	
	self entityStorage remove: anElement. 
	anElement privateSetMooseModel: nil. 
	self privateState flushGroups. 
	^anElement
]

{ #category : #'*Moose-JEE-Core-Model' }
MooseModel >> silentlyRemoveAll: collection [ 
	
	 collection do: [:each | self silentlyRemove: each]. 
	
]
