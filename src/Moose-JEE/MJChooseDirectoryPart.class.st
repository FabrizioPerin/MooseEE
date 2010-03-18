Class {
	#name : #MJChooseDirectoryPart,
	#superclass : #WizardPart,
	#instVars : [
		'folderDialog',
		'title'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJChooseDirectoryPart >> chooseDirectory [

	folderDialog := FileDialogWindow basicNew 
							initialize;
							title: title;
							answerDirectory.

	^self folderDialogContentMorph
]

{ #category : #'as yet unclassified' }
MJChooseDirectoryPart >> folderDialogContentMorph [

	"exact copy of newContentMorph method but instead to create a new list of directory it uses the one already present"

	folderDialog
		directoryTreeMorph: folderDialog directoryTreeMorph;
		fileListMorph: folderDialog fileListMorph;
		previewMorph: folderDialog newPreviewMorph.

	^(folderDialog newRow: {
		folderDialog newColumn: {
			folderDialog newGroupbox: 'Directory' translated for: folderDialog directoryTreeMorph.
			(folderDialog newLabelGroup: {
				'File name' translated->folderDialog newFileNameTextEntry})
				vResizing: #shrinkWrap}.
		folderDialog newGroupbox: 'File' translated forAll: {
			folderDialog fileListMorph.
			folderDialog newActionButtonRow}},
		(folderDialog previewMorph notNil
			ifTrue: [{folderDialog newGroupbox: 'Preview' translated for: folderDialog previewMorph}]
			ifFalse: [#()]))
		vResizing: #spaceFill.
]

{ #category : #'as yet unclassified' }
MJChooseDirectoryPart >> initialize [
	super initialize.
	self populateContents: {( self chooseDirectory )}.
]

{ #category : #'as yet unclassified' }
MJChooseDirectoryPart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "

	^ folderDialog selectedPathName
]
