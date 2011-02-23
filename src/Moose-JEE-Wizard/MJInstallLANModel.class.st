Class {
	#name : #MJInstallLANModel,
	#superclass : #MPImportCommand,
	#category : #'Moose-JEE-Wizard'
}

{ #category : #'as yet unclassified' }
MJInstallLANModel >> execute [
	^LANPackageTestResource new importModel.
]

{ #category : #'as yet unclassified' }
MJInstallLANModel >> label [
	^ 'Install LAN Model'
]
