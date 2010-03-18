Class {
	#name : #MJImportJavaProjectEJB30Command,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJImportJavaProjectEJB30Command >> execute [
	MooseJEEImportInformationForEJB30 new open.
	self updateModelList.
]

{ #category : #'as yet unclassified' }
MJImportJavaProjectEJB30Command >> label [
	^ 'Import Java EJB 3.0 project from MSE file'
]
