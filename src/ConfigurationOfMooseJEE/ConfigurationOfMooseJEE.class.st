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
ConfigurationOfMooseJEE class >> loadAllProjectsDefault [
	
	"TranscriptWindow openWindow.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: 'defaultAllProjects') load.
	
	Smalltalk organization sortCategories.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefault [
	
	"TranscriptWindow openWindow.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: 'default') load.
	
	Smalltalk organization sortCategories.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefaultSQL [
	
	"TranscriptWindow openWindow.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: 'defaultSQL') load.
	
	Smalltalk organization sortCategories.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefaultSQLWithoutTests [
	
	"TranscriptWindow openWindow.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: 'defaultSQLWithoutTests') load.
	
	Smalltalk organization sortCategories.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion10 [
	
	"Transcript open.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: '1.0') load.
	
	(Smalltalk at: #MooseScripts) perform: #openMooseWorkspace.
	"Transcript show: ''; cr; show: 'Moose JEE configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion11 [
	
	"Transcript open.
	Transcript show: 'Loading Moose JEE v.1.1 configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: '1.1') load.

	"Transcript show: ''; cr; show: 'Moose JEE v.1.1 configuration loaded. Have fun!'; cr."

]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion13 [

	(self project version: '1.3') load.
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
		"spec group: 'default' with: #('Core' 'Tests')."
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
		"spec group: 'default' with: #('Core' 'Tests')."
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline12: spec [ 
        <version: '1.2-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec project: 'Moose for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMoose';
				file: 'ConfigurationOfMoose';
				repository: 'http://www.squeaksource.com/Moose' ].
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
		
		spec 
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'pagerank' with: [spec repository: 'http://www.squeaksource.com/pagerank'];	

			package: 'Moose-JEE-Model' with: [spec requires: #( 'Moose for MooseJEE' 'PetitSQLParser for MooseJEE' 'pagerank' )];
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: #( 'Moose for MooseJEE')];
			package: 'Moose-JEE-EJBDraftObjs' with: [spec requires: #('Opax')];
			package: 'Moose-JEE-Tests' with: [spec requires: #('Moose-JEE-Model').];
			package: 'Moose-JEE-Wizard' with: [spec requires: #('Merlin')].
			
			
		spec group: 'Tests' with: #('Moose-JEE-Tests').
		spec group: 'Core' with: #('Moose-JEE-Model' 'Moose-JEE-EJBDraftObjs' 'Moose-JEE-Wizard' 'Moose-JEE-Importers-SQL'). 
		"spec group: 'default' with: #('Core' 'Tests')."
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline13: spec [ 
        <version: '1.3-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
			
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'default';"
				repository: 'http://www.squeaksource.com/Moose' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
			
		spec  project: 'PetitGitLogParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfGitLogParser';
				file: 'ConfigurationOfGitLogParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.squeaksource.com/PetitGitLogParser'].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.squeaksource.com/PetitPHPParser'].
		
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				"version: 'default';"
				repository: 'http://www.squeaksource.com/Maze' ].
			
		spec  project: 'Babel for MooseJEE' with: [
			spec
				className: 'ConfigurationOfBabel';
				file: 'ConfigurationOfBabel';
				"version: 'defaultWithoutMooseJEE';"
				repository: 'http://www.squeaksource.com/Babel' ].

		
		spec 
			"Extra Projects"
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-DesignPattern';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-GitLog-Model';
			package: 'Moose-JEE-CCProject-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			package: 'Moose-JEE-Importers-GitLog' with: [spec requires: 'PetitGitLogParser for MooseJEE'];
			package: 'Moose-JEE-CCProject-Importer' with: [spec requires: 'PetitGitLogParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard' with: [spec requires: 'Merlin'];
			package: 'Moose-JEE-CCProject-XMLElements';
			package: 'Moose-JEE-CCProject-Reports' with: [spec requires: 'Moose-JEE-CCProject-Model'];
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-GitLog' with: [spec requires: #('Moose-JEE-GitLog-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-GitLog' with: [spec requires: #('Moose-JEE-Importers-GitLog' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-DesignPattern' with: [spec requires: #('Moose-JEE-DesignPattern')];
			package: 'Moose-JEE-CCProject-Tests-Resources';
			package: 'Moose-JEE-CCProject-Tests-Model' with: [spec requires: #('Moose-JEE-CCProject-Model' 'Moose-JEE-CCProject-Tests-Resources')];
			package: 'Moose-JEE-CCProject-Tests-Importer' with: [spec requires: #('Moose-JEE-CCProject-Model' 'Moose-JEE-CCProject-Tests-Resources')];
			package: 'Moose-JEE-CCProject-Tests-XMLElements' with: [spec requires: #('Moose-JEE-CCProject-XMLElements' 'Moose-JEE-CCProject-Tests-Resources')].
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		"spec project: 'Moose for MooseJEE' with: [
				spec
					className: 'ConfigurationOfMoose';
					file: 'ConfigurationOfMoose';
					version: 'default';
					repository: 'http://www.squeaksource.com/Moose' ]."
		
		"spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				version: '1.2.0';
				repository: 'http://www.squeaksource.com/XMLSupport' ]."
		
		"spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ]."
			
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				version: 'default';
				repository: 'http://www.squeaksource.com/Moose' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
			
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
			package: 'Moose-JEE-JSP-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-EJB-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Tiers-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			
			
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Browsers' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'];
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
			package: 'Moose-JEE-Tests-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')].
			
		
		spec group: 'Tests' with: #( 
			'Moose-JEE-Tests-Core'
			'Moose-JEE-Tests-SQL'
			'Moose-JEE-Tests-JSP'
			'Moose-JEE-Tests-EJB'
			'Moose-JEE-Tests-Tiers'
			'Moose-JEE-Tests-Extensions'
			'Moose-JEE-Tests-Importers-SQL'
			'Moose-JEE-Tests-Importers-JSP'
			'Moose-JEE-Tests-EJBDraftObjs'
			'Moose-JEE-Tests-Algos').
		
	]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> defaultAllProjects: spec [ 
	<version: 'defaultAllProjects'>
	
	spec for: #common do: [
		spec blessing: #default.
		"spec project: 'Moose for MooseJEE' with: [
				spec
					className: 'ConfigurationOfMoose';
					file: 'ConfigurationOfMoose';
					version: 'default';
					repository: 'http://www.squeaksource.com/Moose' ]."
		
		"spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				version: '1.2.0';
				repository: 'http://www.squeaksource.com/XMLSupport' ]."
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
			
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				version: 'default';
				repository: 'http://www.squeaksource.com/Moose' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
			
		spec  project: 'PetitGitLogParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfGitLogParser';
				file: 'ConfigurationOfGitLogParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitGitLogParser'].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitPHPParser'].
		
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				version: 'default';
				repository: 'http://www.squeaksource.com/Maze' ].
			
		spec  project: 'Babel for MooseJEE' with: [
			spec
				className: 'ConfigurationOfBabel';
				file: 'ConfigurationOfBabel';
				version: 'defaultWithoutMooseJEE';
				repository: 'http://www.squeaksource.com/Babel' ].
		
		"spec  project: 'Spy for MooseJEE' with: [
			spec
				className: 'ConfigurationOfSpy';
				file: 'ConfigurationOfSpy';
				version: 'default';
				repository: 'http://www.squeaksource.com/Spy' ]."
			
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
			package: 'Moose-JEE-JSP-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-EJB-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-DesignPattern' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Tiers-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-GitLog-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-CCProject-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitJSPParser for MooseJEE'];
			package: 'Moose-JEE-Importers-GitLog' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitGitLogParser for MooseJEE'];
			package: 'Moose-JEE-CCProject-Importer' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitGitLogParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Browsers' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Wizard' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Merlin'];
			package: 'Moose-JEE-CCProject-XMLElements' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-CCProject-Reports' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'Moose-JEE-CCProject-Model'];
			package: 'Moose-JEE-Help' with: [spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Tests-Core' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-GitLog' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-GitLog-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-GitLog' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-GitLog' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-DesignPattern' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-DesignPattern')];
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
			'Moose-JEE-Tests-JSP'
			'Moose-JEE-Tests-EJB'
			'Moose-JEE-Tests-Tiers'
			'Moose-JEE-Tests-Extensions'
			'Moose-JEE-Tests-Importers-SQL'
			'Moose-JEE-Tests-Importers-JSP'
			'Moose-JEE-Tests-Importers-GitLog'
			'Moose-JEE-Tests-EJBDraftObjs'
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-DesignPattern'
			'Moose-JEE-CCProject-Tests-Model'
			'Moose-JEE-CCProject-Tests-XMLElements'
			'Moose-JEE-CCProject-Tests-Importer').

	]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> defaultSQL: spec [ 
	<version: 'defaultSQL'>
	
	spec for: #common do: [
		spec blessing: #default.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].

			
		spec
			"Models"
			package: 'Moose-JEE-SQL-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-EJB-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Core-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec repository: 'XMLSupport for MooseJEE'."
				"spec requires: 'Moose for MooseJEE'"];
			
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'];

			"Other utils"
			package: 'Moose-JEE-EJBDraftObjs' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Tests-Core' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
				package: 'Moose-JEE-Tests-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')].
		
		
	]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> defaultSQLWithoutTests: spec [ 
	<version: 'defaultSQLWithoutTests'>
	
	spec for: #common do: [
		spec blessing: #default.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].

		spec
			"Models"
			package: 'Moose-JEE-SQL-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.];
			package: 'Moose-JEE-Core-Model' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec repository: 'XMLSupport for MooseJEE'."
				"spec requires: 'Moose for MooseJEE'"];
			
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'].		
		
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
ConfigurationOfMooseJEE >> version12: spec [
	<version: '1.2' imports: #('1.1-baseline')>

	spec for: #common do: [
		spec blessing: #unstable.
		spec author: 'FabrizioPerin'.
		spec timestamp: '27/08/2010 15:00'.
		
		spec project: 'Moose for MooseJEE' with: '4.1'.
		spec project: 'XMLSupport for MooseJEE' with: '1.1.1'.
		spec project: 'PetitSQLParser for MooseJEE' with: 'default'.
		
		spec
			package: 'Merlin' with: 'Merlin-cyrille_delaunay.72';
			package: 'pagerank' with: 'PageRank-lr.6';
			package: 'Opax' with: 'Opax-FabrizioPerin.18'.			
		
		spec
			package: 'Moose-JEE-Model' with: 'Moose-JEE-Model-FabrizioPerin.80';
			package: 'Moose-JEE-Opax' with: 'Moose-JEE-Opax-FabrizioPerin.2';
			package: 'Moose-JEE-Tests' with: 'Moose-JEE-Tests-FabrizioPerin.39';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.13';
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.12'.
			
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version13: spec [
	<version: '1.3' imports: #('1.3-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release all the project for 1.3'.
		spec timestamp: '09/03/2012 16:00'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'FAMIX SQL for MooseJEE' with: 'default'.
		spec  project: 'PetitJSPParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'PetitGitLogParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'PetitPHPParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'Maze for MooseJEE' with: 'default'.
		spec  project: 'Babel for MooseJEE' with: 'defaultWithoutMooseJEE'.
		
		spec
			package: 'Merlin' with: 'Merlin-CesarCouto.140';
			package: 'pagerank' with: 'PageRank-lr.6';
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: 'Moose-JEE-Core-Model-FabrizioPerin.18';
			package: 'Moose-JEE-SQL-Model' with: 'Moose-JEE-SQL-Model-FabrizioPerin.13';			
			package: 'Moose-JEE-JSP-Model' with: 'Moose-JEE-JSP-Model-FabrizioPerin.4';			
			package: 'Moose-JEE-EJB-Model' with: 'Moose-JEE-EJB-Model-FabrizioPerin.4';
			package: 'Moose-JEE-DesignPattern' with: 'Moose-JEE-DesignPattern-FabrizioPerin.5';
			package: 'Moose-JEE-Tiers-Model' with: 'Moose-JEE-Tiers-Model-FabrizioPerin.8';
			package: 'Moose-JEE-GitLog-Model' with: 'Moose-JEE-GitLog-Model-FabrizioPerin.20';
			package: 'Moose-JEE-CCProject-Model' with: 'Moose-JEE-CCProject-Model-FabrizioPerin.14';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.43';			
			package: 'Moose-JEE-Importers-JSP' with: 'Moose-JEE-Importers-JSP-FabrizioPerin.4';			
			package: 'Moose-JEE-Importers-GitLog' with: 'Moose-JEE-Importers-GitLog-FabrizioPerin.16';			
			package: 'Moose-JEE-CCProject-Importer' with: 'Moose-JEE-CCProject-Importer-FabrizioPerin.15';
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: 'Moose-JEE-Reports-FabrizioPerin.15';			
			package: 'Moose-JEE-EJBDraftObjs' with: 'Moose-JEE-EJBDraftObjs-FabrizioPerin.2';
			package: 'Moose-JEE-Browsers' with: 'Moose-JEE-Browsers-FabrizioPerin.5';
			package: 'Moose-JEE-Algos' with: 'Moose-JEE-Algos-FabrizioPerin.6';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.34';
			package: 'Moose-JEE-CCProject-XMLElements' with: 'Moose-JEE-CCProject-XMLElements-FabrizioPerin.8';
			package: 'Moose-JEE-CCProject-Reports' with: 'Moose-JEE-CCProject-Reports-FabrizioPerin.5';
			package: 'Moose-JEE-Help' with: 'Moose-JEE-Help-FabrizioPerin.2';			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: 'Moose-JEE-Tests-Resources-FabrizioPerin.9';
			package: 'Moose-JEE-Tests-Core' with: 'Moose-JEE-Tests-Core-FabrizioPerin.6';
			package: 'Moose-JEE-Tests-GitLog' with: 'Moose-JEE-GitLog-Model-FabrizioPerin.20';
			package: 'Moose-JEE-Tests-Algos' with: 'Moose-JEE-Tests-Algos-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-Importers-JSP' with: 'Moose-JEE-Tests-Importers-JSP-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-Importers-SQL' with: 'Moose-JEE-Tests-Importers-SQL-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: 'Moose-JEE-Tests-EJBDraftObjs-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-SQL' with: 'Moose-JEE-Tests-SQL-FabrizioPerin.16';			
			package: 'Moose-JEE-Tests-JSP' with: 'Moose-JEE-Tests-JSP-FabrizioPerin.2';
			package: 'Moose-JEE-Tests-EJB' with: 'Moose-JEE-Tests-EJB-FabrizioPerin.5';
			package: 'Moose-JEE-Tests-Extensions' with: 'Moose-JEE-Tests-Extensions-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Importers-GitLog' with: 'Moose-JEE-Tests-GitLog-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Tiers' with: 'Moose-JEE-Tests-Tiers-FabrizioPerin.3';
			package: 'Moose-JEE-Tests-DesignPattern' with: 'Moose-JEE-Tests-DesignPattern-FabrizioPerin.6';
			package: 'Moose-JEE-CCProject-Tests-Resources' with: 'Moose-JEE-CCProject-Tests-Resources-FabrizioPerin.2';
			package: 'Moose-JEE-CCProject-Tests-Model' with: 'Moose-JEE-CCProject-Tests-Model-FabrizioPerin.7';
			package: 'Moose-JEE-CCProject-Tests-Importer' with: 'Moose-JEE-CCProject-Tests-Importer-FabrizioPerin.4';
			package: 'Moose-JEE-CCProject-Tests-XMLElements' with: 'Moose-JEE-CCProject-Tests-XMLElements-FabrizioPerin.5'.
			
		
		spec group: 'Tests' with: #( 
			'Moose-JEE-Tests-Core'
			'Moose-JEE-Tests-SQL'
			'Moose-JEE-Tests-JSP'
			'Moose-JEE-Tests-EJB'
			'Moose-JEE-Tests-Tiers'
			'Moose-JEE-Tests-Extensions'
			'Moose-JEE-Tests-Importers-SQL'
			'Moose-JEE-Tests-Importers-JSP'
			'Moose-JEE-Tests-Importers-GitLog'
			'Moose-JEE-Tests-EJBDraftObjs'
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-DesignPattern'
			'Moose-JEE-CCProject-Tests-Model'
			'Moose-JEE-CCProject-Tests-XMLElements').			
		].
]
