Class {
	#name : #MooseJEEScripts,
	#superclass : #MooseScripts,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #cleanup }
MooseJEEScripts class >> cleanRepositories [
	"self cleanRepositories"
	
	MCRepositoryGroup instVarNamed: 'default' put: nil. 
	self removeAllRepositories.
	self addHomeRepositoryToAllPackages
]

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpAllTests [

	self cleanUpTests.
	self cleanUpMooseTests.
	
	Smalltalk garbageCollect.
]

{ #category : #cleanup }
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
	RPackageOrganizer default packages
		do: [ :each | each methods ifEmpty: [ RPackageOrganizer default unregisterPackage: each ] ]
		displayingProgress: 'Cleaning Packages'.
	Smalltalk organization sortCategories.
	ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
	ChangeSet resetCurrentToNewUnnamedChangeSet.
	Smalltalk garbageCollect.
	Author reset
]

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpFromJenkins [

"Clear Author"
Author reset.

"Clear Monticello Caches"
MCCacheRepository instVarNamed: 'default' put: nil.
MCFileBasedRepository flushAllCaches.
MCMethodDefinition shutDown.
MCDefinition clearInstances.

"Cleanup Smalltalk"
Smalltalk flushClassNameCache.
Smalltalk organization removeEmptyCategories.
Smalltalk allClassesAndTraitsDo: [ :each |
	each organization removeEmptyCategories; sortCategories.
	each class organization removeEmptyCategories; sortCategories ].

"Cleanup System Memory"
Smalltalk garbageCollect.
Symbol compactSymbolTable.
Deprecation raiseWarning: true.

]

{ #category : #cleanup }
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

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpMooseTests [

	#('Moose-JEE-Tests-Algos' 'Moose-JEE-Tests-EJBDraftObjs' 'Moose-JEE-Tests-Importers-JSP' 'Moose-JEE-Tests-Importers-SQL' 'Moose-JEE-Tests-Model'
				'Moose-Tests-Core'
				'Famix-Tests-Core'
				'Famix-Tests-Java'
				'Famix-Tests-Extensions'
				'Moose-Tests-DistributionMap'
				'Moose-Tests-Finder'
				'Moose-Tests-MondrianPaintings'
				'Moose-Tests-SmalltalkImporter-Core'
				'Moose-TestResources-Reference-Core'
				'Moose-TestResources-Reference-PackageOne'
				'Moose-TestResources-Reference-PackageTwo'
				'Moose-Tests-SmalltalkImporter-LAN'
				'Moose-TestResources-LAN'
				'Moose-Tests-SmalltalkImporter-KGB'
				'Moose-TestResources-KGB-P4FullInteracted'
				'Moose-TestResources-KGB-P6InteractedReferee'
				'Moose-TestResources-KGB-P5FullReferee'
				'Moose-TestResources-KGB-P1FullReferencer'
				'Moose-TestResources-KGB-P2InteractedReferencerReferee'
				'Moose-TestResources-KGB-P3InteractedReferencer'
				'Moose-TestResources-KGB-P7ReferencerReferee'
				'Moose-TestResources-KGB-P8FullReferencer'
				'Moose-TestResources-KGB-P9FullReferencer'
				'Moose-TestResources-KGB-P10InteractedReferee'
				'Moose-TestResources-KGB-P11FullReferee'
				'Moose-TestResources-KGB-P12FullReferencer'
				'Moose-TestResources-KGB-P13FullReferencer'
				'Moose-TestResources-KGB-P14FullReferee'
				'Moose-TestResources-KGB-PExtensions'
				'Moose-TestResources-PackageBlueprint-P1'
				'Moose-TestResources-PackageBlueprint-P2'
				'Moose-TestResources-PackageBlueprint-P3'
				'Moose-TestResources-PackageBlueprint-P4'
				'Moose-Tests-MonticelloImporter'
				'Arki-Tests-Reporter') do: [ :each | (MCPackage named: each) unload ]. 

]

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpPackageOrganizer [

	PackageOrganizer default packages
		do: [ :each | 
			each methods isEmpty
				ifTrue: [ PackageOrganizer default unregisterPackage: each ] ]
		displayingProgress: 'Cleaning Packages'
]

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpScript [

	MooseJEEScripts deepCleanUp.
	MooseJEEScripts cleanUpFromJenkins.
	
	Smalltalk garbageCollect
]

{ #category : #cleanup }
MooseJEEScripts class >> cleanUpTests [

	Smalltalk globals at: #SUnitUnloader ifPresent:[ :unloader | unloader new unloadAll  ].

	Smalltalk garbageCollect
]

{ #category : #cleanup }
MooseJEEScripts class >> deepCleanUp [
	"self new cleanUpForProduction"
	
	| oldDicts newDicts |
	
	"trim MC ancestory information"
	MCVersionInfo allInstances do: [ :each | each instVarNamed: 'ancestors' put: nil ].	
		
	"delete ScriptLoader log"
	ScriptLoader resetLogStream.

	"Smalltalk globals at: #SUnitUnloader ifPresent:[ :unloader | unloader new unloadAll  ].
	(MCPackage named: 'HelpSystem-Core') unload.
	(MCPackage named: 'Deprecated12') unload.
	(MCPackage named: 'Deprecated13') unload.
	(MCPackage named: 'ToolBuilder-Morphic') unload.
	(MCPackage named: 'ToolBuilder-Kernel') unload."
	
	"shrink method dictionaries."
	Smalltalk garbageCollect.
	oldDicts := MethodDictionary allInstances.
	newDicts := Array new: oldDicts size.
	oldDicts withIndexDo: [ :d :index | newDicts at: index put: d rehashWithoutBecome ].
	oldDicts elementsExchangeIdentityWith: newDicts.
	oldDicts := newDicts := nil.
	
	"self removeDejaVuFonts.
	(MCPackage named: 'Graphics-Resources') unload.
	
	(MCPackage named: 'HostMenus') unload."
	
	MooseJEEScripts standardCleanUp.
	(MCPackage named: MooseJEEScripts scriptLoaderPackageNameForCleanUp) unload.
	ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
	ChangeSet resetCurrentToNewUnnamedChangeSet.
	RecentMessageList cleanUp.
	
	
]

{ #category : #utils }
MooseJEEScripts class >> deepRecursiveSearchOn: anObject using: aSelector [
	| cursor result includedCobolLists |

	cursor := 1.
	result := OrderedCollection new.
	result add: anObject.
	
	[cursor <= result size] whileTrue: [
		includedCobolLists := ( result at: cursor ) perform: aSelector.
		result addAll: ( includedCobolLists reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]

{ #category : #'font-settings' }
MooseJEEScripts class >> defaultDejaVuFonts [
	"StrikeFont installDejaVu."
	StandardFonts setFontsFromSpec: #(
	        (balloonFont: 'BitmapDejaVu' 8)
	        (buttonFont: 'BitmapDejaVu' 9)
	        (codeFont: 'BitmapDejaVu' 9)
	        (haloFont: 'BitmapDejaVu' 8)
	        (listFont: 'BitmapDejaVu' 9)
	        (menuFont: 'BitmapDejaVu' 9)
	        (defaultFont: 'BitmapDejaVu' 9)
	        (windowTitleFont: 'BitmapDejaVuBold' 12))
]

{ #category : #icons }
MooseJEEScripts class >> flush: aForm toBMPFile: named [ 
	BMPReadWriter putForm: aForm onFileNamed: named
]

{ #category : #icons }
MooseJEEScripts class >> flush: aForm toPNGFile: named [ 
	PNGReadWriter putForm: aForm onFileNamed: named
]

{ #category : #'font-settings' }
MooseJEEScripts class >> largeDemoDejaVuFonts [
	"StrikeFont installDejaVu."
	StandardFonts setDefaultFonts: #(
	        (balloonFont: 'BitmapDejaVu' 10)
	        (buttonFont: 'BitmapDejaVu' 12)
	        (codeFont: 'BitmapDejaVu' 12)
	        (haloFont: 'BitmapDejaVu' 10)
	        (listFont: 'BitmapDejaVu' 12)
	        (menuFont: 'BitmapDejaVu' 12)
	        (defaultFont: 'BitmapDejaVu' 12)
	        (windowTitleFont: 'BitmapDejaVuBold' 16))
]

{ #category : #'font-settings' }
MooseJEEScripts class >> largeDemoFontsSetting [
	| menuFont titleFont codeFont defaultFont |
	menuFont := LogicalFont 
		familyName: 'Helvetica Neue' 
		pointSize: 12 
		stretchValue: (LogicalFont stretchCondensed)  
		weightValue: (LogicalFont weightBold)  
		slantValue: (LogicalFont slantNormal).
	titleFont := LogicalFont 
		familyName: 'Helvetica Neue' 
		pointSize: 16 
		stretchValue: (LogicalFont stretchCondensed) 
		weightValue: (LogicalFont weightBold) 
		slantValue: (LogicalFont slantNormal).
	codeFont := LogicalFont familyName: 'Monaco' pointSize: 14.
	defaultFont := LogicalFont familyName: 'Helvetica Neue' pointSize: 14.
	Preferences setSystemFontTo: defaultFont.
	Preferences setListFontTo: defaultFont.
	Preferences setFlapsFontTo: menuFont.
	Preferences setHaloLabelFontTo: defaultFont.
	Preferences setMenuFontTo: menuFont.
	Preferences setWindowTitleFontTo: titleFont.
	Preferences setBalloonHelpFontTo: defaultFont.
	Preferences setCodeFontTo: codeFont.
	Preferences setButtonFontTo: defaultFont.


]

{ #category : #cleanup }
MooseJEEScripts class >> methodsCleanUp [
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

{ #category : #cleanup }
MooseJEEScripts class >> packageOrganizerCleanUp [

	RPackageOrganizer default packages
		do: [ :each | 
			each methods isEmpty
				ifTrue: [ RPackageOrganizer default unregisterPackage: each ] ]
		displayingProgress: 'Cleaning Packages'
]

{ #category : #utils }
MooseJEEScripts class >> print: aCollectionOfElements asCSVOn: aStream with: aHeader using: aBlock [ 
	
	UIManager default
		displayProgress: 'Exporting in CSV'
		from: 1 
		to: aCollectionOfElements size
		during: [ :bar | 
			| index |
			index := 1.
			aStream nextPutAll: aHeader.
			aCollectionOfElements
				do: [ :edge | 
				
					aStream nextPutAll: (aBlock value: edge).
					
					index := index + 1.
					bar value: index. ]].
	aStream close.  
]

{ #category : #utils }
MooseJEEScripts class >> readCSVFile [
	"This method read CSV file from the file system and return is content as a list of lines"
	
	| fileStream |

	fileStream := UITheme builder 
		fileOpen: 'Import csv file' 
		extensions: #('csv').

	^ fileStream contentsOfEntireFile lines
]

{ #category : #cleanup }
MooseJEEScripts class >> resetAuthor [
	Author reset.

]

{ #category : #cleanup }
MooseJEEScripts class >> scriptLoaderPackageNameForCleanUp [
	^'ScriptLoader',  CurrentMajorVersionNumber asString copyWithout: $. 
]

{ #category : #cleanup }
MooseJEEScripts class >> standardCleanUp [
	"self new cleanUpForRelease"

	Author fullName: 'Mr.Cleaner'.
	self packageOrganizerCleanUp.
	self methodsCleanUp.
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

{ #category : #icons }
MooseJEEScripts class >> transformToArray: anIconImageFileName [
"This method return an array representing the icon file given in input"
"| form |
form := Form fromBinaryStream: (FileStream fileNamed: '/Users/fabrizioperin/Desktop/drawing.png')."
"with this you get the array that represent the image"
"form bits asArray"
	| form |
	
	form := Form fromBinaryStream: (FileStream fileNamed: anIconImageFileName).
	^form bits asArray.
 
]

{ #category : #'as yet unclassified' }
MooseJEEScripts >> seeClassSide [
]
