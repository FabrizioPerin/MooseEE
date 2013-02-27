Extension { #name : #MooseModel }

{ #category : #'*moose-jee-designpattern' }
MooseModel >> allRoles [
	<navigation: 'All DP Roles'>

	^self allWithType: MJDPRole ofGroupClass: MJDPRoleGroup
]

{ #category : #'*moose-jee-designpattern' }
MooseModel >> importPatternDefinitionFromUI [
	<menuItem: 'Import pattern definition from file' category: 'JEAs Importers'>
	| file |
	
	file := UITheme builder 
		fileOpen: 'select file to pattern definition file'
		extensions: nil.
		
	file isNil 
		ifTrue: [DialogWindow new alert: 'No file selected.']
	 	ifFalse: [
			| importer |
			importer := MARPLEImporter on: self. 
			importer importPatternDefinitionFrom: file].
	
	^self
]
