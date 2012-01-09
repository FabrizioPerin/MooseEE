Extension { #name : #MooseModel }

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
