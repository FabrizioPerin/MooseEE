Class {
	#name : #MooseJEEScripts,
	#superclass : #MooseScripts,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MooseJEEScripts class >> cleanUpForRelease [
	"self new cleanUpForRelease"

	Author fullName: 'Mr.Cleaner'.
	self cleanUpPackageOrganizer.
	self cleanUpMethods.
	Smalltalk cleanUp: true except: #() confirming: false.
	ImageMorph classPool at: #DefaultForm put: (Form extent: 1 @ 1 depth: 1).
	Smalltalk organization removeEmptyCategories.
	Smalltalk globals
		at: #TTFontDescription
		ifPresent: [ :c | 
			c
				clearDefault;
				clearDescriptions ].
	ExternalDropHandler resetRegisteredHandlers.
	FreeTypeFontProvider current initialize.
	SystemNavigation default
		allObjectsDo: [ :each | 
			(each respondsTo: #releaseCachedState)
				ifTrue: [ each releaseCachedState ] ].
	3 timesRepeat: [ 
		Smalltalk garbageCollect.
		Symbol compactSymbolTable ].
	HashedCollection rehashAll.
	
	"Remove empty categories, which are not in MC packages, because MC does
	not do this (this script does not make packages dirty)"
	Smalltalk organization removeEmptyCategories.
	Smalltalk
		allClassesAndTraitsDo: [ :class |
			[ :each |
				each
					removeEmptyCategories;
					sortCategories ]
						value: class organization;
						value: class class organization ].
	PackageOrganizer default packages
		do: [ :each | each methods ifEmpty: [ PackageOrganizer default unregisterPackage: each ] ]
		displayingProgress: 'Cleaning Packages'.
	Smalltalk organization sortCategories.
	ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
	ChangeSet resetCurrentToNewUnnamedChangeSet.
	Smalltalk garbageCollect.
	Author reset
]

{ #category : #'as yet unclassified' }
MooseJEEScripts class >> cleanUpMethods [
	"Make sure that all methods in use are restarted"
	"ScriptLoader new cleanUpMethods"

	WeakArray restartFinalizationProcess.
	MethodChangeRecord allInstancesDo: [:x | x noteNewMethod: nil].
	WorldState allInstancesDo: [ :ws | ws convertAlarms; convertStepList; resetWorldMenu].
	WorldState allInstancesDo: [ :ws | ws instVarNamed: 'menuBuilder' put: nil ].
	ExternalDropHandler initialize.
	ScrollBar initializeImagesCache.
	GradientFillStyle initPixelRampCache.
	ProcessBrowser initialize.
	Smalltalk garbageCollect.
	Delay startTimerEventLoop
]

{ #category : #'as yet unclassified' }
MooseJEEScripts class >> cleanUpPackageOrganizer [

	PackageOrganizer default packages
		do: [ :each | 
			each methods isEmpty
				ifTrue: [ PackageOrganizer default unregisterPackage: each ] ]
		displayingProgress: 'Cleaning Packages'
]

{ #category : #workspace }
MooseJEEScripts class >> openDoitWorkspaceWith: anArray [ 
	"self openDoitWorkspaceWith: {'a'. 'b'. 'c'}"
	| w wsClass |
	wsClass := Smalltalk at: #SHWorkspace ifAbsent: [Smalltalk at: #Workspace].
	w := wsClass new.
	w contents: (anArray 
			inject: ''
			into: [ :string :doit | string , doit , $. asString , Character cr asString ]).
	w openLabel: 'Moose JEE Workspace'.
]

{ #category : #workspace }
MooseJEEScripts class >> openMooseJEEWorkspace [
	"
	self openMooseJEEWorkspace
	"
	self openDoitWorkspaceWith: {'"Moose 4.0

Moose is a platform for software and data analysis.
More information can be found on: 
- the official webpage: http://moosetechnology.org
- the online book: http://themoosebook.org.

This Image contains the extension MOOSE JEE to analyze 
Java Enterprise Applications.
You can start with Moose JEE from the import menu of the Moose panel"'.

'

"Select and execute:"
MoosePanel open'.}
]

{ #category : #workspace }
MooseJEEScripts class >> openMooseJEEWorkspacePositioned [
	"
	self openMooseJEEWorkspacePositioned
	"
	|message|
	
	message := '"Moose 4.0

Moose is a platform for software and data analysis.
More information can be found on: 
- the official webpage: http://moosetechnology.org
- the online book: http://themoosebook.org"


"This Image contains the extension MOOSE JEE to analyze 
Java Enterprise Applications
You can start with Moose JEE from the import menu of the Moose panel"

"Select and execute:"
MoosePanel open'.

	self openWorkspaceWith: message startingFrom: 180@10 andExtendItUntil: 500@300.
]

{ #category : #workspace }
MooseJEEScripts class >> openWorkspaceWith: aString startingFrom: aStartingPoint andExtendItUntil: anEndPoint [ 

	(SHWorkspace new
	acceptContents: aString;
	embeddedInMorphicWindowLabeled: 'Moose JEE Workspace')
	position: aStartingPoint;
 	extent: anEndPoint;
   openAsIs
]
