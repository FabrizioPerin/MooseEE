Class {
	#name : #MooseJEEImportInformationForEJB21,
	#superclass : #WizardControl,
	#instVars : [
		'progBar',
		'mooseModel'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 class >> new: aMooseModel [

	^self new initialize: aMooseModel; yourself.
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> information [
	self inform: self informationText.
	MooseImportFromJavaSourceFilesWizard  new openFirstWizardPane.
	self updateModelList .

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> initialize: aMooseModel [
	| wizardPane1 wizardPane2 wizardPart1 wizardPart2 |
	
	super initialize.
	
	mooseModel := aMooseModel.
	
	wizardPane1 := WizardFirstPane named: 'Information'.
	wizardPane2 := WizardLastPane named: 'Select the source code directory'.
	
	wizardPart1 := MJInfoPart new initialize.
	wizardPane1 addPart: wizardPart1 associatedTo: #nothing.
 	
	wizardPart2 := MJChooseDirectoryPart new.
	wizardPane2 addPart: wizardPart2 associatedTo: #sourceDirectoryPath.

	self addPane: wizardPane1.
	self addPane: wizardPane2.



	

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> performTerminateButtonAction [
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
MooseJEEImportInformationForEJB21 >> validateImportation [
	| sourcePath sourcePathName |
	
	sourcePathName := wizardInformations at: #sourceDirectoryPath.

	self halt.

	(sourcePathName isNil or: [ sourcePathName = ''])
		ifTrue:[ DialogWindow new alert: 'File not found.']
		ifFalse: [ 
			sourcePath := FileDirectory on: sourcePathName.
			mooseModel importEjbJarFromFolder: sourcePath pathName.].
	progBar value: 4.
		
	mooseModel annotateTheModelForJEEBrowser.
	progBar value: 5.
]
