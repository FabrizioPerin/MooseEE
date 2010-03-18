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
MooseJEEImportInformationForEJB21 >> actionsToPerform [
	| sourcePathName mseFilePathName |
	
	sourcePathName := wizardInformations at: #sourceDirectoryPath.
	mseFilePathName := wizardInformations at: #mseFilePathName.

	"Import Model"

	mooseModel := MooseModel new.
	mooseModel name: (mseFilePathName sliceFrom: ((mseFilePathName findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1) to: (mseFilePathName size - 4)  ).
	mooseModel importFromMSEStream: (StandardFileStream readOnlyFileNamed: mseFilePathName).
	progBar value: 3.
	
	"Import other information"
	mooseModel size > 0 
		ifFalse:[DialogWindow new alert: 'No Model installed']
		ifTrue:[
			(sourcePathName isNil or: [ sourcePathName = ''])
				ifTrue:[ DialogWindow new alert: 'Path incorrect']
				ifFalse: [ 
					mooseModel importEjbJarFromFolder: sourcePathName.].
			progBar value: 4.
		
			mooseModel annotateTheModelForJEEBrowser.
			progBar value: 5.
			
			MooseModel root add: mooseModel.
			progBar value: 6.
		]
			
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> initialize [
	| wizardPane1 wizardPane2 wizardPart1 wizardPart2 wizardPane3 wizardPart3 |
	
	super initialize.
	
	mooseModel := nil.
	
	wizardPane1 := WizardFirstPane named: 'Information'.
	wizardPane2 := WizardMiddlePane named: 'Select the MSE file of the project'.
	wizardPane3 := WizardLastPane named: 'Select the source code directory'.
	
	wizardPart1 := MJInfoPart new initialize.
	wizardPane1 addPart: wizardPart1 associatedTo: #nothing.
 
	wizardPart2 := MJChooseFilePart new.
	wizardPane2 addPart: wizardPart2 associatedTo: #mseFilePathName.
	
	wizardPart3 := MJChooseDirectoryPart new.
	wizardPane3 addPart: wizardPart3 associatedTo: #sourceDirectoryPath.

	self addPane: wizardPane1.
	self addPane: wizardPane2.	
	self addPane: wizardPane3.



	

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB21 >> performTerminateButtonAction [
	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
	"^self subclassResponsibility"
	UIManager default
		displayProgress: 'Importing'
		at: Sensor cursorPoint
		from: 1 
		to: 6
		during: [ :bar | 
			progBar := bar. 
			progBar value: 2.
			super performTerminateButtonAction .
			self actionsToPerform.].
]
