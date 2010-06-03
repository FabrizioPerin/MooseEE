Class {
	#name : #MooseJEEScripts,
	#superclass : #Object,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #workspace }
MooseJEEScripts class >> openDoitWorkspaceWith: anArray [ 
	"self openDoitWorkspaceWith: {'a'. 'b'. 'c'}"
	| w wsClass |
	wsClass := Smalltalk at: #SHWorkspace ifAbsent: [Smalltalk at: #Workspace].
	w := wsClass new.
	w contents: (anArray 
			inject: ''
			into: [ :string :doit | string , doit , $. asString , Character cr asString ]).
	w openLabel: 'Moose JEE Workspace'
]

{ #category : #workspace }
MooseJEEScripts class >> openMooseJEEWorkspace [
	"
	self openMooseJEEWorkspace
	"

	self openDoitWorkspaceWith: {
			'"Moose 4.0

Moose is a platform for software and data analysis.
More information can be found on: 
- the official webpage: http://moosetechnology.org
- the online book: http://themoosebook.org"'.

'

"This Image contains the extension MOOSE JEE to analyze 
Java Enterprise Applications
You can start with Moose JEE from the import menu of the Moose panel"'.
			'
"Select and execute:"
MoosePanel open'
			}
]

{ #category : #workspace }
MooseJEEScripts class >> openMooseReleaseWorkspace [
	"
	self openMooseReleaseWorkspace
	"

	self openDoitWorkspaceWith: {
			'"Moose is a platform for analysis and visualization.
More information can be found at: http://moose.unibe.ch"'.
			'
"Select and execute:"
MoosePanel open'
			}
]

{ #category : #workspace }
MooseJEEScripts class >> openMooseWorkspace [
	"
	self openMooseWorkspace
	"

	self openDoitWorkspaceWith: {
			'"Tools"'.
			'MoosePanel open				"browse Moose models in root"'.
			'MooseModel browseMeta		"browse metamodel and doc"'.
			'MOEasel open'.
			'"Models"'.
			'MooseScripts browse "some loading scripts, class-side"'.
			'MooseModel installDefaultModels'.
			'PackageOrganizerCache resetDefault "reset package cache"'.
			'"Metacello"'.
			'MooseDevBrowser open 		"open Moose browser for Metacello"'.
			}

]
