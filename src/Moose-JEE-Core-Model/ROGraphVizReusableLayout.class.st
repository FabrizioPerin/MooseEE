Class {
	#name : #ROGraphVizReusableLayout,
	#superclass : #ROGraphVizLayout,
	#instVars : [
		'existingLayout'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #accessing }
ROGraphVizReusableLayout >> existingLayout [
	^ existingLayout
]

{ #category : #accessing }
ROGraphVizReusableLayout >> existingLayout: anObject [
	existingLayout := anObject
]

{ #category : #accessing }
ROGraphVizReusableLayout >> initialize [ 
	super initialize.
	
	self existingLayout: nil.
	
	^self
]

{ #category : #'as yet unclassified' }
ROGraphVizReusableLayout >> on: elements edges: edgeElements [
	
	| positions |
	
	self ids: (self createIdMapping: elements).
	
	self reuseExistingLayout
		ifFalse: [ 
			self removeTemporaryFiles.

			self createDotFileNodes: elements connections: edgeElements.
			
			self callGraphViz isNil ifTrue: [^ self] ].
		
	positions := self readLayoutFile.
	
	self applyLayoutToNodes: elements with: positions
]

{ #category : #accessing }
ROGraphVizReusableLayout >> readLayoutFile [
	| dot positions element controlPoints point separator |

	self reuseExistingLayout
		ifTrue: [ dot := FileStream readOnlyFileNamed: self existingLayout ]
		ifFalse: [ dot := FileStream readOnlyFileNamed: 'mondrian_plain' ].

	positions := Dictionary new.
	OSProcess isWindows
		ifTrue: [ separator := String crlf ]
		ifFalse: [ separator := String lf ].
	
	"graph header"
	element := (dot upToAll: separator ) subStrings: ' '.
	self extent: ((element at: 3) asNumber @ (element at: 4) asNumber) * self scaleFactor.
	
	"each line"
	element := (dot upToAll: separator) subStrings: ' '.
	
	[ (element at: 1) ~= 'stop' and: [ (element at: 1) ~= '' ] ]
		whileTrue: [
			"if node, save its position"
			(element first) = 'node' ifTrue: [
				positions at: (element at: 2) asNumber
						 put: (((element at: 3) asNumber) @ ((element at: 4) asNumber) * self scaleFactor)
			].

			"if edge, save all its control points"
			element first = 'edge' ifTrue: [
				controlPoints := OrderedCollection new.
				0 to: ((element at: 4) asNumber - 1) do: [ :index |
					point := ((element at: 5 + (index*2)) asNumber @ (element at: 6 + (index*2)) asNumber).
					controlPoints add: point * self scaleFactor .
				].
			
				positions at: ((element at: 2) asNumber -> (element at: 3) asNumber)
						 put: controlPoints.
			].
			
			element := (dot upToAll: separator) subStrings: ' '.
		].
	
	( self existingLayout isNil not and: [ dot name endsWith: 'mondrian_plain' ] )
		ifTrue: [ self saveLayout ].
	
	^ positions
]

{ #category : #accessing }
ROGraphVizReusableLayout >> reuseExistingLayout [
	^self existingLayout isNil not and: [ ( FileSystem disk referenceTo: self existingLayout) exists]
]

{ #category : #accessing }
ROGraphVizReusableLayout >> reuseOrSaveLayout: aFilePathName [

	existingLayout := aFilePathName.
]

{ #category : #'as yet unclassified' }
ROGraphVizReusableLayout >> saveLayout [
	| outputLayout |
	
	outputLayout := StandardFileStream forceNewFileNamed: self existingLayout.
		
	outputLayout nextPutAll: (FileStream readOnlyFileNamed: 'mondrian_plain') contentsOfEntireFile.
	
	outputLayout close.
]
