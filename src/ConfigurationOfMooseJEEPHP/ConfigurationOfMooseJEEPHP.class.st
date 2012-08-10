Class {
	#name : #ConfigurationOfMooseJEEPHP,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseJEEPHP
}

{ #category : #private }
ConfigurationOfMooseJEEPHP class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseJEEPHP class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseJEEPHP class >> loadDefault [
	
	"TranscriptWindow openWindow.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: 'default') load.
	
	Categorizer sortAllCategories.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #accessing }
ConfigurationOfMooseJEEPHP class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseJEEPHP >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		"spec project: 'MooseJEE for MooseJEEPHP' with: [
				spec
					className: 'ConfigurationOfMooseJEE';
					file: 'ConfigurationOfMooseJEE';
					version: 'defaultAllProjects';
					repository: 'http://www.squeaksource.com/Moose' ]."
		
		spec project: 'PHPParser for MooseJEEPHP' with: [
				spec
					className: 'ConfigurationOfPetitPHPParser';
					file: 'ConfigurationOfPetitPHPParser';
					version: 'default';
					repository: 'http://www.squeaksource.com/PetitPHPParser' ].		
			
		spec 
			"Models"
			package: 'Moose-JEE-PHP-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];			
			
			"importers"
			package: 'Moose-JEE-Importers-PHP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('PHPParser for MooseJEEPHP')];
	
			"Tests"
			package: 'Moose-JEE-Tests-Importers-PHP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-PHP')].
			"package: 'Moose-JEE-Tests-PHP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-PHP-Model' 'Moose-JEE-Tests-PHP-Resources')];
			package: 'Moose-JEE-Tests-Importers-PHP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-PHP' 'Moose-JEE-Tests-PHP-Resources')]."
			
		
		"spec group: 'Tests' with: #( 
			'Moose-JEE-Tests-PHP-Resources'
			'Moose-JEE-Tests-PHP'
			'Moose-JEE-Tests-Importers-PHP'
			)."
		
	]
]

{ #category : #baselines }
ConfigurationOfMooseJEEPHP >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
