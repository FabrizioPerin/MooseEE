Class {
	#name : #ChooseDirectoryPart,
	#superclass : #WizardPart,
	#instVars : [
		'folderDialog'
	],
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
ChooseDirectoryPart >> chooseDirectory [

	folderDialog := FileDialogWindow basicNew 
							initialize;
							title: 'Choose Folder';
							answerDirectory.

	^self contentMorphOf
]

{ #category : #'as yet unclassified' }
ChooseDirectoryPart >> contentMorphOf [

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
ChooseDirectoryPart >> contentMorphOf: aFolderDialog [

	"exact copy of newContentMorph method but instead to create a new list of directory it uses the one already present"

	aFolderDialog
		directoryTreeMorph: aFolderDialog directoryTreeMorph;
		fileListMorph: aFolderDialog fileListMorph;
		previewMorph: aFolderDialog newPreviewMorph.

	^(aFolderDialog newRow: {
		aFolderDialog newColumn: {
			aFolderDialog newGroupbox: 'Directory' translated for: aFolderDialog directoryTreeMorph.
			(aFolderDialog newLabelGroup: {
				'File name' translated->aFolderDialog newFileNameTextEntry})
				vResizing: #shrinkWrap}.
		aFolderDialog newGroupbox: 'File' translated forAll: {
			aFolderDialog fileListMorph.
			aFolderDialog newActionButtonRow}},
		(aFolderDialog previewMorph notNil
			ifTrue: [{aFolderDialog newGroupbox: 'Preview' translated for: aFolderDialog previewMorph}]
			ifFalse: [#()]))
		vResizing: #spaceFill.
]

{ #category : #'as yet unclassified' }
ChooseDirectoryPart >> initialize [
	super initialize.
	self populateContents: {( self chooseDirectory )}.
]
