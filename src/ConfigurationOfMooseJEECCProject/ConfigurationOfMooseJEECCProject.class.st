"
ConfigurationOfMooseJEECCProject loadDefaut


Instance Variables:
	project	<ProtoObject>
"
Class {
	#name : #ConfigurationOfMooseJEECCProject,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseJEECCProject
}

{ #category : #private }
ConfigurationOfMooseJEECCProject class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseJEECCProject class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseJEECCProject class >> loadDefault [
	
	(self project version: 'default') load.
	
]

{ #category : #accessing }
ConfigurationOfMooseJEECCProject class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseJEECCProject >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec project: 'Moose for MooseJEE' with: [
				spec
					className: 'ConfigurationOfMoose';
					file: 'ConfigurationOfMoose';
					version: 'default';
					repository: 'http://www.squeaksource.com/Moose' ].
	
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				version: 'default';
				repository: 'http://www.squeaksource.com/Moose' ].
		
		spec  project: 'Spy for MooseJEE' with: [
			spec
				className: 'ConfigurationOfSpy';
				file: 'ConfigurationOfSpy';
				version: 'default';
				repository: 'http://www.squeaksource.com/Spy' ].
			
		spec 
			"Extra Projects"
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec repository: 'XMLSupport for MooseJEE'."
				"spec requires: 'Moose for MooseJEE'"];
			package: 'Moose-JEE-SQL-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];

			package: 'Moose-JEE-EJB-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-CCProject-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-CCProject-Importer' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitGitLogParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Algos' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'];
			package: 'Moose-JEE-CCProject-XMLElements' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Help' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Tests-Core' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			
			package: 'Moose-JEE-Tests-Algos' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			
			package: 'Moose-JEE-Tests-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			
			package: 'Moose-JEE-Tests-EJB' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Tests-Resources')];

			
			package: 'Moose-JEE-CCProject-Tests-Resources' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-CCProject-Tests-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-CCProject-Model' 'Moose-JEE-CCProject-Tests-Resources')];
			package: 'Moose-JEE-CCProject-Tests-Importer' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-CCProject-Model' 'Moose-JEE-CCProject-Tests-Resources')];
			package: 'Moose-JEE-CCProject-Tests-XMLElements' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-CCProject-XMLElements' 'Moose-JEE-CCProject-Tests-Resources')].
			
		
		spec group: 'Tests' with: #( 
			'Moose-JEE-Tests-Core'
			'Moose-JEE-Tests-SQL'

			'Moose-JEE-Tests-EJB'

			'Moose-JEE-Tests-Extensions'
			'Moose-JEE-Tests-Importers-SQL'

			'Moose-JEE-Tests-EJBDraftObjs'
			'Moose-JEE-Tests-Algos'

			'Moose-JEE-CCProject-Tests-Model'
			'Moose-JEE-CCProject-Tests-XMLElements'
			'Moose-JEE-CCProject-Tests-Importer').

	]
]

{ #category : #accessing }
ConfigurationOfMooseJEECCProject >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
