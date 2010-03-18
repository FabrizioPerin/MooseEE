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
MooseJEEImportInformationForEJB30 >> actionsToPerform [
	| sqlFileNamePath mseFilePathName |
	
	sqlFileNamePath := wizardInformations at: #SQLFileName.
	mseFilePathName := wizardInformations at: #mseFilePathName.

	"Import Model"

	mooseModel := MooseModel new.
	mooseModel name: (mseFilePathName sliceFrom: ((mseFilePathName findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1)  to: (mseFilePathName size - 4)  ).
	mooseModel importFromMSEStream: (StandardFileStream readOnlyFileNamed: mseFilePathName).
	progBar value: 3.
	
	"Import other information"
	mooseModel size > 0 
		ifFalse:[DialogWindow new alert: 'No Model installed']
		ifTrue:[
			sqlFileNamePath isNil 
				ifTrue:[ DialogWindow new alert: 'File not found.']
				ifFalse: [ 
					mooseModel importDBFromSQLFile: (StandardFileStream readOnlyFileNamed: sqlFileNamePath) ].
			progBar value: 4.
	
			mooseModel instanciateJBeansFromAnnotations.
			progBar value: 5.
	
			mooseModel annotateTheModelForJEEBrowser.
			progBar value: 6.
			
			MooseModel root add: mooseModel.
			progBar value: 7.
		]
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> initialize [
	 
	| wizardPane1 wizardPart1 wizardPane2 wizardPart2 wizardPart3 folderName wizardPane3 |
	super initialize.	
	
	mooseModel := nil.
	
	wizardPane1 := WizardFirstPane named: 'Information'.
	wizardPane2 := WizardMiddlePane named: 'Select the MSE file of the project'.
	wizardPane3 := WizardLastPane named: 'Import information from SQL file'.
	
	wizardPart1 := MJInfoPart new initialize.
	wizardPane1 addPart: wizardPart1 associatedTo: #nothing.
 	
	wizardPart2 := MJChooseFilePart new.
	wizardPane2 addPart: wizardPart2 associatedTo: #mseFilePathName.
	
	wizardPart3 := MJChooseFilePart new.
	wizardPane3 addPart: wizardPart3 associatedTo: #SQLFileName.

	self addPane: wizardPane1.
	self addPane: wizardPane2.
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
		to: 7
		during: [ :bar | 
			progBar := bar. 
			progBar value: 2.
			super performTerminateButtonAction.
			self actionsToPerform.].

	
]
