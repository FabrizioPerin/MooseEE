Extension { #name : #MooseModel }

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> cleanAllClonesInfo [
	<menuItem: 'Clean up all clones info' category: 'JEAs Utilities'>

	self silentlyRemoveAll: (self allWithType: MJCCPSource).
	self silentlyRemoveAll: (self allWithType: MJCCPClass).
	self silentlyRemoveAll: (self allWithType: MJCCPClones).
	self silentlyRemoveAll: (self allWithType: MJCCPClassinfo).
	self silentlyRemoveAll: (self allWithType: MJCCPSysteminfo).

	self allClasses do: #cleanAllCloneSources.

	Smalltalk garbageCollect.
	
]

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importCloneInfoUI [
	<menuItem: 'Import clones info from XML report' category: 'JEAs Importers'>
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from XML report'
		extensions: #('xml').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse: [self importClonesInfoFrom: file readStream].
]

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importClonesInfoFrom: aStream [
	| importer |

	importer := MJCCReportImporter on: self.
	
	importer importFrom: aStream.
	
	
]
