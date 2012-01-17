Extension { #name : #MooseModel }

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importCloneInfoFromFolderUI [
	<menuItem: 'Import clones info from folder XML report' category: 'JEAs Importers'>
	| folder |
	
	folder := UITheme builder 
		chooseDirectory: 'Import information from XML reports in a folder'.

	folder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.'.]
		ifFalse: [
			folder entries do: [:entry | 
				(entry name endsWith: '.xml') "endsWith: is casesensitive"
					ifTrue: [
						self importClonesInfoFrom: entry readStream ] ].
			DialogWindow new inform: 'Import process completed'.].
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
		ifFalse: [
			self importClonesInfoFrom: file readStream.
			DialogWindow new inform: 'Import process completed'.].
]

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importClonesInfoFrom: aStream [
	| importer |

	importer := MJCCReportImporter on: self.
	
	importer importFrom: aStream.
	
	
]
