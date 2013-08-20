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
		spec repository: 'http://smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		spec 
			package: 'MooseJEE-PHP-Model';
			package: 'MooseJEE-Importers-PHP' with: [spec requires:#('MooseJEE-PHP-Model' 'PPPHPParser for MooseJEEPHP')];
			package: 'MooseJEE-Tests-Importers-PHP' with: [spec requires: #('MooseJEEImporters-PHP')].
		
		spec project: 'PHPParser for MooseJEEPHP' with: [
				spec
					className: 'ConfigurationOfPetitPHPParser';
					file: 'ConfigurationOfPetitPHPParser';
					version: 'default';
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main' ]
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
