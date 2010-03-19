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
	
	progBar value: 'Importing from sql file'.
	
	"Import other information"
	mooseModel size > 0 
		ifFalse:[DialogWindow new alert: 'No Model installed']
		ifTrue:[
			sqlFileNamePath isNil 
				ifTrue:[ DialogWindow new alert: 'File not found.']
				ifFalse: [ 
					mooseModel importDBFromSQLFile: (StandardFileStream readOnlyFileNamed: sqlFileNamePath) ].
			progBar value: 4.
	
			progBar value: 'Creating annotations'.
	
			mooseModel instanciateJBeansFromAnnotations.
			progBar value: 5.
			
			mooseModel annotateTheModelForJEEBrowser.
			progBar value: 6.
			
			MooseModel root add: mooseModel.
			progBar value: 7.
			
			progBar value: 'Performing post import operations'.
			
			(wizardInformations at: #openVisualizations) 
						ifTrue:[
							mooseModel allModelClasses viewTransactionFlow3.
							progBar value: 8.
			
							mooseModel allModelClasses viewUnsafeQueries.
							progBar value: 9.]
						ifFalse:[progBar value: 9].
						
			(wizardInformations at: #openBrowsers) 
						ifTrue:[
							mooseModel browseCodeWithAnnotationsForJEA.
							progBar value: 10.]
						ifFalse:[progBar value: 10].
		]
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> buildWizardPanels [
	
	
	| pane1 pane2 pane3 pane4 part1 part2 part3 part4 part5 |
	pane1 := WizardFirstPane named: 'Information'.
	pane2 := WizardMiddlePane named: 'Select the MSE file of the project'.
	pane3 := WizardMiddlePane named: 'Import information from SQL file'.
	pane4 := WizardLastPane named: 'After import operations'.
	
	part1 := MJInfoPart new: self informationText.
	pane1 addPart: part1 associatedTo: #nothing.
 	
	part2 := MJChooseFilePart new.
	pane2 addPart: part2 associatedTo: #mseFilePathName.
	
	part3 := MJChooseFilePart new.
	pane3 addPart: part3 associatedTo: #SQLFileName.
	
	part4 :=  MJCheckboxPart new: 'Open visualizations'.
	part4 selected: true.
	pane4 addPart: part4 associatedTo: #openVisualizations.
	
	part5 :=  MJCheckboxPart new: 'Open annotations browser'.
	part5 selected: true.
	pane4 addPart: part5 associatedTo: #openBrowsers.
	
	
	self addPane: pane1.
	self addPane: pane2.
	self addPane: pane3.
	self addPane: pane4.

	

]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> informationText [
	^'To properly use all the functionality og Moose JEE on a Java project you need 
	different information. In the following some panel will required you:
	
		- The location of the MSE file of the JAva project you plan to analize.
		- The location of the SQL script to import information related to the data base used by the application.'
	
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> initialize [

	super initialize.	
	mooseModel := nil.
	
	self buildWizardPanels.
	
	
]

{ #category : #'as yet unclassified' }
MooseJEEImportInformationForEJB30 >> performTerminateButtonAction [
	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
	"^self subclassResponsibility"
	UIManager default
		displayProgress: 'Importing'
		at: Sensor cursorPoint
		from: 1 
		to: 10
		during: [ :bar | 
			progBar := bar. 
			progBar value: 2.
			super performTerminateButtonAction.
			self actionsToPerform.].

	
]
