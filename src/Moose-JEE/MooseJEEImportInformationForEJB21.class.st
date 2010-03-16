Class {
	#name : #MooseJEEImportInformationForEJB21,
	#superclass : #WizardControl,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> initialize [
	 
	| wizardPane1 wizardPart1 wizardPane2 wizardPart2 wizardPart3 folderName |
	super initialize.
	wizardPane1 := WizardFirstPane named: 'Select the source code directory'.
	
	wizardPart1 := ChooseDirectoryPart new.

	wizardPane1 addPart: wizardPart1 associatedTo: #sourceDirectoryPath.

	self addPane: wizardPane1.

	

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> performTerminateButtonAction [
	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
	"^self subclassResponsibility"
	super performTerminateButtonAction .
	self validateImportation.
	
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> validateImportation [

	| mooseModel wizardMessagePane |
	"["
	mooseModel := MooseModel new importFromMSEStream: (StandardFileStream readOnlyFileNamed: (wizardInformations at: #mseFilePath)) filteredBy: ( self createImportingContext).
"	mooseModel := MooseModel new importFromMSEStream: (StandardFileStream readOnlyFileNamed: (wizardInformations at: #mseFilePath))."
	
	MooseModel root add: mooseModel .

	"]

		on: Error 
		do: [:ex |
			wizardMessagePane:= WizardMessagePane new. 
			wizardMessagePane addPart: (TextDisplayPart forText:'Invalid MSE file caued Error:  ', ex description)  associatedTo: nil.
			self addPane: wizardMessagePane .
			wizardMessagePane open.
			]."
]
