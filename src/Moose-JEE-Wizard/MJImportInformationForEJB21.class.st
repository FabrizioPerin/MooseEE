Class {
	#name : #MJImportInformationForEJB21,
	#superclass : #WizardControl,
	#instVars : [
		'progBar',
		'mooseModel'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJImportInformationForEJB21 >> actionsToPerform [
	| sourcePathName mseFilePathName appLayers |
	
	sourcePathName := wizardInformations at: #sourceDirectoryPath.
	mseFilePathName := wizardInformations at: #mseFilePathName.

	"Import Model"

	mooseModel := MooseModel new.
	mooseModel name: (mseFilePathName sliceFrom: ((mseFilePathName findLastOccurrenceOfString: FileDirectory slash startingAt: 1) + 1) to: (mseFilePathName size - 4)  ).
	mooseModel importFromMSEStream: (StandardFileStream readOnlyFileNamed: mseFilePathName).
	mooseModel ejbVersion: #EJB21.
	progBar value: 3.
	
	progBar value: 'Importing from ejb-jar files'.
	
	"Import other information"
	mooseModel size > 0 
		ifFalse:[DialogWindow new alert: 'No Model installed']
		ifTrue:[
			(sourcePathName isNil or: [ sourcePathName = ''])
				ifTrue:[ DialogWindow new alert: 'Path incorrect']
				ifFalse: [ 
					mooseModel importEjbJarFromFolder: sourcePathName.].
			progBar value: 4.
			
			"progBar value: 'Creating annotations'.
		
			mooseModel annotateTheModelForJEEBrowser."
			progBar value: 5.
			
			progBar value: 'Performing post import operations'.
			
			mooseModel fixFileAnchorsFrom: (FileDirectory on: sourcePathName).
			progBar value: 6.
			
			"appLayers := (MJFAMIXLayer allSubclasses select: [:class | class allSubclasses isEmpty]) collect: [:class | class name].
			appLayers do: [:layerClassNameSymbol | ((Smalltalk at: layerClassNameSymbol) perform: #new) populate: mooseModel]."
			progBar value: 7.

			mooseModel install.

			"MooseModel root add: mooseModel."
			progBar value: 8.

			(wizardInformations at: #openVisualizations) 
						ifTrue:[
							mooseModel allModelClasses viewTransactionFlow.
							progBar value: 9.
			
							mooseModel allModelClasses viewUnsafeQueries.
							progBar value: 10.]
						ifFalse:[progBar value: 10].
						
			(wizardInformations at: #openBrowsers) 
						ifTrue:[
							mooseModel browseCodeWithAnnotationsForJEA.
							progBar value: 11.]
						ifFalse:[progBar value: 11].
		]
			
]

{ #category : #'as yet unclassified' }
MJImportInformationForEJB21 >> buildWizardPanels [
	| pane1 pane2 pane3 part1 part2 part3 part4 pane4 part5 |
	
	pane1 := WizardFirstPane named: 'Information'.
	pane2 := WizardMiddlePane named: 'Select the MSE file of the project'.
	pane3 := WizardMiddlePane named: 'Select the source code directory'.
	pane4 := WizardLastPane named: 'After import operations'.
	
	part1 := TextPart new text: self informationText.
	pane1 addPart: part1 associatedTo: #nothing.
 
	part2 := ChooseFilePart new.
	pane2 addPart: part2 associatedTo: #mseFilePathName.
	
	part3 := ChooseFilePart new.
	pane3 addPart: part3 associatedTo: #sourceDirectoryPath.

	part4 :=  CheckboxPart new label: 'Open visualizations'.
	part4 selected: true.
	pane4 addPart: part4 associatedTo: #openVisualizations.
	
	part5 :=  CheckboxPart new label: 'Open annotations browser'.
	part5 selected: true.
	pane4 addPart: part5 associatedTo: #openBrowsers.

	self addPane: pane1.
	self addPane: pane2.	
	self addPane: pane3.
	self addPane: pane4.



	

]

{ #category : #'as yet unclassified' }
MJImportInformationForEJB21 >> informationText [
	^'To properly use all the functionality og Moose JEE on a Java project you need 
	different information. In the following some panel will required you:
	
		- The location of the MSE file of the Java project you plan to analize.
		- The location of the root directory of the project that you intend to analyze.'
	
]

{ #category : #'as yet unclassified' }
MJImportInformationForEJB21 >> initialize [

	super initialize.
	mooseModel := nil.
	
	self buildWizardPanels.

	

]

{ #category : #'as yet unclassified' }
MJImportInformationForEJB21 >> performTerminateButtonAction [
	"by default, just close the last current pane. Override this method if you want to create a subclass of WizardControl making a specific action"
	"^self subclassResponsibility"
	UIManager default
		displayProgress: 'Processing'
		from: 1 
		to: 11
		during: [ :bar | 
			progBar := bar. 
			progBar value: 2.
			super performTerminateButtonAction .
			self actionsToPerform.].
]
