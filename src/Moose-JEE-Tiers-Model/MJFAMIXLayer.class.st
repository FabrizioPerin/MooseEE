Class {
	#name : #MJFAMIXLayer,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedClasses'
	],
	#category : #'Moose-JEE-Tiers-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLayer class >> annotation [
	<MSEClass: #MJFAMIXLayer super: #FAMIXEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> acceptStrategy: aLayeringStrategy [
	^self subclassResponsibility
]

{ #category : #accessing }
MJFAMIXLayer >> belongsTo [ 
	^''
]

{ #category : #accessing }
MJFAMIXLayer >> containedClasses [
	<navigation: 'Contained Elements'>
	^containedClasses
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> fileOutContainedClasses [
	<menuItem: 'File out contained classes list' category: 'JEAs Utilities'>
	| stream name |
	
	name := self name.
	name := name removeSuffix: ' Layer'.
	
	stream := MultiByteFileStream forceNewFileNamed: (name , '.out').
	
	self containedClasses do: [:class |
		stream nextPutAll: (class mooseName asString , String cr asString)].
	stream close.
]

{ #category : #initialization }
MJFAMIXLayer >> initialize [ 
	super initialize.
	containedClasses := Set new.
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> populate: aMooseModel [

	| layer |

	layer := self selectClassesFrom: aMooseModel.
	aMooseModel add: layer.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> selectClassesFrom: aMooseModel [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> viewCSLayer [
	<menuItem: 'CS Layer' category: 'Visualize'> 
	| view |
	
	view := MOViewRenderer new.
	self viewCSLayerOn: view.
	view open.
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> viewCSLayerOn: view [
	| groupOfContainedElements |

	groupOfContainedElements := BAComponentGroup withAll: containedClasses.

	view interaction popupText.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view shape rectangle
		width: [ :el | el containedElements size ];
		height: [ :el | el containedElements size ];
		linearFillColor: [ :el | el numberOfLinesOfCode ]	within: groupOfContainedElements;
		withBorder.
	view nodes: self containedClasses.
	
	view edges: self mooseModel allComponentAssociations from: #source to: #target.
	
	view treeLayout.
]
