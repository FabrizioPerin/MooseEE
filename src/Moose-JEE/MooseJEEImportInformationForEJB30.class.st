Class {
	#name : #MooseJEEImportInformationForEJB30,
	#superclass : #WizardControl,
	#instVars : [
		'progBar',
		'mooseModel'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 class >> new: aMooseModel [

	^self new initialize: aMooseModel; yourself.
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> information [
	self inform: self informationText.
	MooseImportFromJavaSourceFilesWizard  new openFirstWizardPane.
	self updateModelList .

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> initialize: aMooseModel [
	 
	| wizardPane1 wizardPart1 wizardPane2 wizardPart2 wizardPart3 folderName wizardPane3 |
	super initialize.
	
	mooseModel := aMooseModel.
	
	wizardPane1 := WizardFirstPane named: 'Information'.
	"wizardPane2 := WizardMiddlePane named: 'Select the source code directory'."
	wizardPane3 := WizardLastPane named: 'Import information from SQL file'.
	
	wizardPart1 := MJInfoPart new initialize.
	wizardPane1 addPart: wizardPart1 associatedTo: #nothing.
 	
	"wizardPart2 := MJChooseDirectoryPart new.
	wizardPane2 addPart: wizardPart2 associatedTo: #sourceDirectoryPath."
	
	wizardPart3 := MJChooseFilePart new.
	wizardPane3 addPart: wizardPart3 associatedTo: #SQLFileName.

	self addPane: wizardPane1.
	"self addPane: wizardPane2."
	self addPane: wizardPane3.

	

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> performTerminateButtonAction [
	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
	"^self subclassResponsibility"
	UIManager default
		displayProgress: 'Importing'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
			progBar := bar. 
			progBar value: 2.
			super performTerminateButtonAction .
			self validateImportation.].

	
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> validateImportation [

	
	| sqlFileNamePath |
	
	sqlFileNamePath := wizardInformations at: #SQLFileName.

	sqlFileNamePath isNil 
		ifTrue:[ DialogWindow new alert: 'File not found.']
		ifFalse: [ mooseModel importDBFromSQLFile: (StandardFileStream readOnlyFileNamed: sqlFileNamePath) ].
	progBar value: 3.
	
	mooseModel instanciateJBeansFromAnnotations.
	progBar value: 4.
	
	mooseModel annotateTheModelForJEEBrowser.
	progBar value: 5.
]
