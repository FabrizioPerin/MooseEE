Class {
	#name : #ConfigurationOfMooseJEE,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseJEE
}

{ #category : #private }
ConfigurationOfMooseJEE class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseJEE class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefault [
	
	Transcript open.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr.
	
	(self project version: 'default') load.
	
	(Smalltalk at: #MooseScripts) perform: #openMooseWorkspace.
	Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr.

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefaultWithoutMoose [

	Transcript open.
	Transcript show: 'Loading Moose JEE configuration without Moose ...'; cr; show: '--------'; cr; cr.
	
	(self project version: 'defaultWithoutMoose') load.

	Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr.


]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadLastStable [
	
	Transcript open.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr.
	
	(self project version: 'laststable') load.
	
	(Smalltalk at: #MooseScripts) perform: #openMooseWorkspace.
	Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr.

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadPXDefaultWithoutMoose [

	Transcript open.
	Transcript show: 'Loading Moose JEE configuration without Moose ...'; cr; show: '--------'; cr; cr.
	
	(self project version: 'pXDefaultWithoutMoose') load.

	Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr.


]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion10 [
	
	Transcript open.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr.
	
	(self project version: '1.0') load.
	
	(Smalltalk at: #MooseScripts) perform: #openMooseWorkspace.
	Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr.

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion11 [
	
	Transcript open.
	Transcript show: 'Loading Moose JEE v.1.1 configuration ...'; cr; show: '--------'; cr; cr.
	
	(self project version: '1.1') load.

	Transcript show: ''; cr; show: 'Moose JEE v.1.1 configuration loaded. Have fun!'; cr.

]

{ #category : #accessing }
ConfigurationOfMooseJEE class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline10: spec [ 
        <version: '1.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec project: 'Moose for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMoose';
				file: 'ConfigurationOfMoose';
				repository: 'http://www.squeaksource.com/Moose' ].
			
		spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				repository: 'http://www.squeaksource.com/XMLSupport' ].
		
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'Opax' with: [
				spec repository: 'http://www.squeaksource.com/OPAX'. 
				spec requires: #('XMLSupport for MooseJEE')];		

			package: 'PEGSQLParser' with: [spec repository: 'http://www.squeaksource.com/PEGSQLParser'];
			package: 'Moose-JEE-Model' with: [spec requires: #( 'Moose for MooseJEE')];
			package: 'Moose-JEE-Opax' with: [spec requires: #('Opax')];
			package: 'Moose-JEE-Tests' with: [spec requires: #('Moose-JEE-Model').];
			package: 'Moose-JEE-Wizard' with: [spec requires: #('Merlin')].
			
			
		spec group: 'Tests' with: #('Moose-JEE-Tests').
		spec group: 'Core' with: #('Moose-JEE-Model' 'Moose-JEE-Opax' 'Moose-JEE-Wizard'). 
		spec group: 'default' with: #('Core' 'Tests').
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline11: spec [ 
        <version: '1.1-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec project: 'Moose for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMoose';
				file: 'ConfigurationOfMoose';
				repository: 'http://www.squeaksource.com/Moose' ].
			
		spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				repository: 'http://www.squeaksource.com/XMLSupport' ].
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
		
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'pagerank' with: [spec repository: 'http://www.squeaksource.com/pagerank'];
			package: 'Opax' with: [
				spec repository: 'http://www.squeaksource.com/OPAX'. 
				spec requires: #('XMLSupport for MooseJEE')];		

			package: 'Moose-JEE-Model' with: [spec requires: #( 'Moose for MooseJEE' 'PetitSQLParser for MooseJEE' 'pagerank' )];
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: #( 'Moose for MooseJEE')];
			package: 'Moose-JEE-Opax' with: [spec requires: #('Opax')];
			package: 'Moose-JEE-Tests' with: [spec requires: #('Moose-JEE-Model').];
			package: 'Moose-JEE-Wizard' with: [spec requires: #('Merlin')].
			
			
		spec group: 'Tests' with: #('Moose-JEE-Tests').
		spec group: 'Core' with: #('Moose-JEE-Model' 'Moose-JEE-Opax' 'Moose-JEE-Wizard' 'Moose-JEE-Importers-SQL'). 
		spec group: 'default' with: #('Core' 'Tests').
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec project: 'Moose for MooseJEE' with: [
				spec
					className: 'ConfigurationOfMoose';
					file: 'ConfigurationOfMoose';
					version: 'default';
					repository: 'http://www.squeaksource.com/Moose' ].
		
		"spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				version: '1.1.1';
				repository: 'http://www.squeaksource.com/XMLSupport' ]."
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
			
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			package: 'Opax' with: [spec repository: 'http://www.squeaksource.com/OPAX']; 
			package: 'Moose-JEE-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec requires: 'Moose for MooseJEE'"];
			package: 'Moose-JEE-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Model'];
			package: 'Moose-JEE-Opax' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Opax'];
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitJSPParser for MooseJEE'];
			package: 'Moose-JEE-Tests' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'].
		spec group: 'Tests' with: #( 'Moose-JEE-Tests').
	]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> defaultWithoutMoose: spec [ 
	<version: 'defaultWithoutMoose'>

	spec for: #common do: [
		spec blessing: #default.
		
		"spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				version: '1.1.1';
				repository: 'http://www.squeaksource.com/XMLSupport' ]."
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
		
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			package: 'Opax' with: [
				spec repository: 'http://www.squeaksource.com/OPAX'.
				"spec requires: 'XMLSupport for MooseJEE'"]; 
			package: 'Moose-JEE-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec requires: 'Moose for MooseJEE'"];
			package: 'Moose-JEE-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Model'];
			package: 'Moose-JEE-Opax' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Opax'];
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitJSPParser for MooseJEE'];
			package: 'Moose-JEE-Tests' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'].
		spec group: 'Tests' with: #( 'Moose-JEE-Tests').
	]

]

{ #category : #baselines }
ConfigurationOfMooseJEE >> pXdefaultWithoutMoose: spec [ 
	<version: 'pXDefaultWithoutMoose'>

	spec for: #common do: [
		spec blessing: #default.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
		
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank'];
			package: 'Petit-SQL-Parametrix' with: [spec repository: 'http://www.squeaksource.com/PetitSQLParser']; 
			package: 'Opax' with: [
				spec repository: 'http://www.squeaksource.com/OPAX'.
				"spec requires: 'XMLSupport for MooseJEE'"]; 
			package: 'Moose-JEE-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec requires: 'Moose for MooseJEE'"];
			package: 'Moose-JEE-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Model'];
			package: 'Moose-JEE-Opax' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Opax'];
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitJSPParser for MooseJEE'];
			package: 'Moose-JEE-Tests' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'];
			package: 'Moose-JEE-Parametrix' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'].
		spec group: 'Tests' with: #( 'Moose-JEE-Tests').
	]

]

{ #category : #accessing }
ConfigurationOfMooseJEE >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec timestamp: '16/08/2010 15:00'.
		
		spec project: 'Moose for MooseJEE' with: '4.1'.
		spec project: 'XMLSupport for MooseJEE' with: '1.0.6'.

		spec
			package: 'Merlin' with: 'Merlin-cyrille_delaunay.71';
			package: 'Opax' with: 'Opax-FabrizioPerin.15';
			package: 'PEGSQLParser' with: 'PEGSQLParser-FabrizioPerin.28'.
		
		spec
			package: 'Moose-JEE-Model' with: 'Moose-JEE-Model-FabrizioPerin.32';
			package: 'Moose-JEE-Opax' with: 'Moose-JEE-Opax-FabrizioPerin.2';
			package: 'Moose-JEE-Tests' with: 'Moose-JEE-Tests-FabrizioPerin.16';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.9'.
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version11: spec [
	<version: '1.1' imports: #('1.1-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec timestamp: '27/08/2010 15:00'.
		
		spec project: 'Moose for MooseJEE' with: '4.1'.
		spec project: 'XMLSupport for MooseJEE' with: '1.1.1'.
		spec project: 'PetitSQLParser for MooseJEE' with: 'default'.
		
		spec
			package: 'Merlin' with: 'Merlin-cyrille_delaunay.72';
			package: 'pagerank' with: 'PageRank-lr.6';
			package: 'Opax' with: 'Opax-FabrizioPerin.15'.			
		
		spec
			package: 'Moose-JEE-Model' with: 'Moose-JEE-Model-FabrizioPerin.44';
			package: 'Moose-JEE-Opax' with: 'Moose-JEE-Opax-FabrizioPerin.2';
			package: 'Moose-JEE-Tests' with: 'Moose-JEE-Tests-FabrizioPerin.20';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.9';
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.1'.
			
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> versionLastStable: spec [
	<version: 'laststable' imports: #('1.1-baseline')>

	spec for: #common do: [
		spec blessing: #development.
		spec author: 'FabrizioPerin'.
		spec timestamp: '06/22/2010 15:53'.
		spec description: 'Stable version of Moose JEE'.
		
		spec project: 'Moose for MooseJEE' with: 'default'.

		spec
			package: 'Merlin' with: 'Merlin-cyrille_delaunay.62';
			package: 'XML-Parser' with: 'XML-Parser-Alexandre_Bergel.81'.
		
		spec
			package: 'Moose-JEE-Model' with: 'Moose-JEE-Model-FabrizioPerin.33';
			package: 'Moose-JEE-Opax' with: 'Moose-JEE-Opax-FabrizioPerin.2';
			package: 'Moose-JEE-Tests' with: 'Moose-JEE-Tests-FabrizioPerin.16';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.9';
			package: 'Moose-JEE-PetitSQLParser' with: 'Moose-JEE-PEGSQLParser-FabrizioPerin.1';
			package: 'Moose-JEE-SQL' with: 'Moose-JEE-SQL-FabrizioPerin.1'.
		].
]
