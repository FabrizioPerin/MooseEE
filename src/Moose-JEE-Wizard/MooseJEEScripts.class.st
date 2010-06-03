Class {
	#name : #MooseJEEScripts,
	#superclass : #MooseScripts,
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
- the online book: http://themoosebook.org"'.

'

"This Image contains the extension MOOSE JEE to analyze 
Java Enterprise Applications
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
