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
	(self project version: 'default') load.
]

{ #category : #loading }
ConfigurationOfMooseJEEPHP class >> loadDefaultWithoutPetit [
	(self project version: 'defaultWithoutPetit') load.
]

{ #category : #accessing }
ConfigurationOfMooseJEEPHP class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseJEEPHP >> default: spec [
	<version: 'default'>
	spec
		for: #common
		do: [ 
			spec blessing: #default.
			spec repository: 'http://smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
			spec
				package: 'Moose-JEE-PHP-Model';
				package: 'Moose-JEE-Importers-PHP' with: [ spec requires: #('Moose-JEE-PHP-Model' 'PPPHPParser for MooseJEEPHP') ];
				package: 'Moose-JEE-Tests-Importers-PHP' with: [ spec requires: #('Moose-JEE-Importers-PHP') ].
			"spec
				project: 'Moose for MooseJEEPHP'
				with: [ 
					spec
						className: 'ConfigurationOfMoose';
						file: 'ConfigurationOfMoose';
						symbolicVersion: 'stable';
						repository: 'http://smalltalkhub.com/mc/Moose/Moose/main' ]."
			spec
				project: 'PPPHPParser for MooseJEEPHP'
				with: [ 
					spec
						className: 'ConfigurationOfPetitPHPParser';
						file: 'ConfigurationOfPetitPHPParser';
						symbolicVersion: 'defaultWithoutPetit';
						repository: 'http://smalltalkhub.com/mc/Moose/PetitPHPParser/main' ] ]
]

{ #category : #baselines }
ConfigurationOfMooseJEEPHP >> defaultWithoutPetit: spec [
	<version: 'defaultWithoutPetit'>
	spec
		for: #common
		do: [ 
			spec blessing: #default.
			spec repository: 'http://smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
			spec
				package: 'Moose-JEE-PHP-Model';
				package: 'Moose-JEE-Importers-PHP' with: [ spec requires: #('Moose-JEE-PHP-Model' 'PPPHPParser for MooseJEEPHP') ];
				package: 'Moose-JEE-Tests-Importers-PHP' with: [ spec requires: #('Moose-JEE-Importers-PHP') ].
				
			spec
				project: 'PPPHPParser for MooseJEEPHP'
				with: [ 
					spec
						className: 'ConfigurationOfPetitPHPParser';
						file: 'ConfigurationOfPetitPHPParser';
						version: 'defaultWithoutPetit';
						repository: 'http://smalltalkhub.com/mc/Moose/PetitPHPParser/main' ] ]
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
