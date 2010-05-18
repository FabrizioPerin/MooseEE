Class {
	#name : #MJInfoPart,
	#superclass : #WizardPart,
	#instVars : [
		'infoDialog',
		'informationText'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJInfoPart class >> new: aString [
	^self new initialize: aString; yourself.
]

{ #category : #'as yet unclassified' }
MJInfoPart >> contentMorph [
	"Answer a new content morph."

	| groupboxMorph answer |
	
	infoDialog iconMorph: infoDialog newIconMorph.
	infoDialog textMorph: infoDialog textMorph.
	^infoDialog newGroupboxFor: (infoDialog newRow: {infoDialog iconMorph. infoDialog textMorph})
]

{ #category : #'as yet unclassified' }
MJInfoPart >> infoPanel [

	infoDialog := MessageDialogWindow new
			textFont: UITheme current textFont;
			title: 'Initialization';
			text: self informationText.

	^self contentMorph
]

{ #category : #'as yet unclassified' }
MJInfoPart >> informationText [
	^informationText
]

{ #category : #'as yet unclassified' }
MJInfoPart >> initialize: aString [

	super initialize.
	informationText := aString.
	self populateContents: {( self infoPanel )}.
]

{ #category : #'as yet unclassified' }
MJInfoPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	""
	^nil
]
