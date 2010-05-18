Class {
	#name : #MJCheckboxPart,
	#superclass : #WizardPart,
	#instVars : [
		'model',
		'label',
		'checkbox'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJCheckboxPart class >> new: aString [
	^self new initialize: aString; yourself.
]

{ #category : #'as yet unclassified' }
MJCheckboxPart >> checkbox [

	checkbox := self 
				newCheckboxFor: (model := ValueHolder new contents: true)
				getSelected: #contents
				setSelected: #contents:
				label: label.
	checkbox buttonMorph selected: true.
	
	^checkbox
]

{ #category : #'as yet unclassified' }
MJCheckboxPart >> initialize: aString [

	super initialize.
	label := aString.
	self populateContents: {( self checkbox )}.
]

{ #category : #'as yet unclassified' }
MJCheckboxPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "
	"return true or false according the checkbox is selected or not"
	^ model contents
]

{ #category : #'as yet unclassified' }
MJCheckboxPart >> selected: trueOrFalse [
	"select or unselect the checkbox according the value of trueOrFalse "
	checkbox buttonMorph selected: trueOrFalse.
]
