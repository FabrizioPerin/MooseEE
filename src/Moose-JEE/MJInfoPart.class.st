Class {
	#name : #MJInfoPart,
	#superclass : #WizardPart,
	#instVars : [
		'infoDialog'
	],
	#category : #'Moose-JEE-Wizard'
}

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
	^ 'To import Java you need inFusion to translate the Java application into an MSE file. If you do not have it, you can find it at:
	http://www.intooitus.com/inFusion-tryit.html

	To link Moose with inFusion, you need to indicate the path to "java2mse.sh". Just specify its location in the next pane.'
]

{ #category : #'as yet unclassified' }
MJInfoPart >> initialize [

	super initialize.
	self populateContents: {( self infoPanel )}.
]

{ #category : #'as yet unclassified' }
MJInfoPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	""
	^nil
]
