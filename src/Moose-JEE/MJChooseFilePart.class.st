Class {
	#name : #MJChooseFilePart,
	#superclass : #WizardPart,
	#instVars : [
		'folderDialog',
		'title',
		'fileDialog'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJChooseFilePart >> chooseSQLFile [

	fileDialog := FileDialogWindow basicNew 
							initialize;
							title: title;
							answerOpenFile.

	^self fileDialogContentMorph
]

{ #category : #'as yet unclassified' }
MJChooseFilePart >> fileDialogContentMorph [

	"exact copy of newContentMorph method but instead to create a new list of directory it uses the one already present"

	fileDialog
		directoryTreeMorph: fileDialog directoryTreeMorph;
		fileListMorph: fileDialog fileListMorph;
		previewMorph: fileDialog newPreviewMorph.

	^(fileDialog newRow: {
		fileDialog newColumn: {
			fileDialog newGroupbox: 'Directory' translated for: fileDialog directoryTreeMorph.
			(fileDialog newLabelGroup: {
				'File name' translated->fileDialog newFileNameTextEntry})
				vResizing: #shrinkWrap}.
		fileDialog newGroupbox: 'File' translated forAll: {
			fileDialog fileListMorph.
			fileDialog newActionButtonRow}},
		(fileDialog previewMorph notNil
			ifTrue: [{fileDialog newGroupbox: 'Preview' translated for: fileDialog previewMorph}]
			ifFalse: [#()]))
		vResizing: #spaceFill.
]

{ #category : #'as yet unclassified' }
MJChooseFilePart >> initialize [
	super initialize.
	title := ''.
	self populateContents: {( self chooseSQLFile )}.
]

{ #category : #'as yet unclassified' }
MJChooseFilePart >> outputValue [
	"this method is an abstract method as only the subclass itself know what is the information to send to the WizardPane which will send it  to the wizarControl "

	^fileDialog selectedPathName
]
