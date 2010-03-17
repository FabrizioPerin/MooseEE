Class {
	#name : #MJInfoPartOLD,
	#superclass : #WizardPart,
	#instVars : [
		'textMorph',
		'iconMorph',
		'infoDialog'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> contentMorph [
	"Answer a new content morph."

	| groupboxMorph answer |
	
	infoDialog iconMorph: infoDialog newIconMorph.
	infoDialog textMorph: infoDialog textMorph.
	^infoDialog newGroupboxFor: (infoDialog newRow: {infoDialog iconMorph. infoDialog textMorph})
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> icon [
	"Answer an icon for the receiver."
	
	^UITheme current infoIcon
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> iconMorph [

	^ImageMorph new image: self icon
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> iconMorph: anObject [
	"Set the value of iconMorph"

	iconMorph := anObject
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> infoPanel [

	infoDialog := MessageDialogWindow basicNew 
							initialize;
							text: self informationText.

	^self contentMorph




	"copy of the method MessageDailogWindows>>newContentMorph "

"	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	^self newGroupboxFor: (self newRow: {self iconMorph. self textMorph})"
"	| groupboxMorph answer |
	
	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	
	groupboxMorph := PlainGroupboxMorph new
		cornerStyle: #square;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent;
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8.
		
	{self iconMorph. self textMorph} do: [:m | answer addMorphBack: m].
	
	^groupboxMorph addMorph: answer"
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> informationText [
	^ 'To import Java you need inFusion to translate the Java application into an MSE file. If you do not have it, you can find it at:
	http://www.intooitus.com/inFusion-tryit.html

	To link Moose with inFusion, you need to indicate the path to "java2mse.sh". Just specify its location in the next pane.'
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> initialize [

	super initialize.
	self populateContents: {( self infoPanel )}.
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> newContentMorph [
	"Answer a new content morph."

	| groupboxMorph answer |
	
	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	
	groupboxMorph := PlainGroupboxMorph new
		cornerStyle: UITheme current preferredCornerStyle;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8.
		
	{self iconMorph. self textMorph} do: [:m | answer addMorphBack: m].
	
	^groupboxMorph addMorph: answer
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> newIconMorph [
	"Answer an icon for the receiver."
	
	^ImageMorph new image: self icon
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> newTextMorph [

 ^TextMorph new
		wrapFlag: true;
		contents: self informationText;
		font: self textFont;
		autoFit: true;
		lock;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	""
	^nil
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> textFont [
	^UITheme current textFont
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> textMorph [
	"get the value of textMorph"

	^textMorph
]

{ #category : #'as yet unclassified' }
MJInfoPartOLD >> textMorph: anObject [
	"Set the value of textMorph"

	textMorph := anObject
]
