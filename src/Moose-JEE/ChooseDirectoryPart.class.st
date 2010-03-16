Class {
	#name : #ChooseDirectoryPart,
	#superclass : #WizardPart,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
ChooseDirectoryPart >> chooseDirectory [

	folderDialog := FileDialogWindow basicNew
		initialize;
		title: 'Choose Folder';
		answerDirectory.
	
	folderDialog answerDirectory.

	folderDialog selectPathName: FileDirectory root pathName.
	
	^ folderDialog newContentMorph.
]

{ #category : #'as yet unclassified' }
ChooseDirectoryPart >> initialize [
	super initialize.
	self populateContents: {( self chooseDirectory )}.
]
