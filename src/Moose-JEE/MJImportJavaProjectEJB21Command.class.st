Class {
	#name : #MJImportJavaProjectEJB21Command,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJImportJavaProjectEJB21Command >> execute [
	MJImportInformationForEJB21 new open.
	self updateModelList.
]

{ #category : #'as yet unclassified' }
MJImportJavaProjectEJB21Command >> label [
	^ 'Import Java EJB 2.1 project from MSE file'
]
