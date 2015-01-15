Extension { #name : #MooseModel }

{ #category : #'*mobi-mooseee-architecture-model' }
MooseModel >> allApplications [
	<navigation: 'Applications'>
	| group |
	
	group := self allWithType: MobiApplication ofGroupClass: MobiApplicationGroup.
	group description: 'Applications'.
	
	^group
]

{ #category : #'*mobi-mooseee-architecture-model' }
MooseModel >> importApplications [
	<menuItem: 'Import applications' category: 'Mobi Importers'>
	(MobiApplicationsImporter on: self) populateModelWithApplications 
]
