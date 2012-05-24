Class {
	#name : #MJMergeModelsInANewOne,
	#superclass : #WizardControl,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> actionsToPerform [
	| modelNames modelsToMerge newMooseModel |

	modelNames := self wizardInformations at: #selectedItems.
	modelsToMerge := self retrieveTheMooseModelFrom: modelNames.

	newMooseModel := MooseModel new.
	newMooseModel name: 'newModel'.
	
	modelsToMerge do: [:model | newMooseModel addAll: model entities].
	
	newMooseModel install.
]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> buildWizardPanels [

	| wizardPane itemsSelectorsPart |

	wizardPane := WizardSinglePane new.
	
	itemsSelectorsPart := MultiSelectionItemSelectorPart new
								initialList: (OrderedCollection withAll: (MooseModel root entities collect: #name));
								yourself.
		
	wizardPane row: itemsSelectorsPart associatedTo: #selectedItems.
		
	self addPane: wizardPane. 

]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> informationText [
	^'This functionality allow you to merge two or more models. The only panel will required you to select the model to merge. As a result all the selected models will be merged and a new model will be created.'
	
]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> initialize [

	super initialize.	
	self buildWizardPanels.
	
	
]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> performTerminateButtonAction [

	super performTerminateButtonAction.
	self actionsToPerform.
	
]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOne >> retrieveTheMooseModelFrom: aModelNamesCollection [

	^aModelNamesCollection flatCollect: [:each | MooseModel root select: [:model | model name = each]].
	
	

]
