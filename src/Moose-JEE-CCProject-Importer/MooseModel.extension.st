Extension { #name : #MooseModel }

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importCloneInfoFromFolderUI [
	<menuItem: 'Import XML clones reports from folder' category: 'JEAs Importers'>
	| folder |
	
	folder := UITheme builder 
		chooseDirectory: 'Import information from XML reports in a folder'.

	folder isNil 
		ifTrue: [ DialogWindow new alert: 'Folder not found.'.]
		ifFalse: [
			| xmlFiles |
			xmlFiles := folder entries select: [:entry | entry name endsWith: '.xml'].
			
			MooseCustomTask 
				runWithProgress: [:bar | 
					| importer |

					importer := MJCCReportImporter on: self.
			
					xmlFiles do: [:file | 
						self importCloneReportWith: importer From: file readStream.
						bar increment. ].
					
					importer linkSourcesAndFilesOrClasses.] 
		
				description: 'Importing ' , xmlFiles size asString , ' code clones reports'
				length: xmlFiles size.
			
			DialogWindow new inform: 'Import process completed'. ].
]

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importCloneInfoUI [
	<menuItem: 'Import XML clones report' category: 'JEAs Importers'>
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from XML report'
		extensions: #('xml').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse: [
			| importer |
			
			importer := MJCCReportImporter on: self.
			self importCloneReportWith: importer From: file readStream.
			importer linkSourcesAndFilesOrClasses.
			
			DialogWindow new inform: 'Import process completed'.].
]

{ #category : #'*moose-jee-ccproject-importer' }
MooseModel >> importCloneReportWith: anImporter From: aStream [

	anImporter importFrom: aStream.
	
]
