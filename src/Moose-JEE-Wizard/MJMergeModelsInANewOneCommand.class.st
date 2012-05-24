Class {
	#name : #MJMergeModelsInANewOneCommand,
	#superclass : #MoosePanelCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOneCommand >> execute [
	^MJMergeModelsInANewOne new open
]

{ #category : #'as yet unclassified' }
MJMergeModelsInANewOneCommand >> label [
	^'Merge models in a new one'
]
