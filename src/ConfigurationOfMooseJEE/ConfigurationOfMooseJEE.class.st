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
ConfigurationOfMooseJEE class >> loadDevelopment [
	^(self project version: #development) load
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadStable [
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion10 [
	
	"Transcript open.
	Transcript show: 'Loading Moose JEE configuration ...'; cr; show: '--------'; cr; cr."
	
	(self project version: '1.0') load.
	
	(Smalltalk at: #MooseScripts) perform: #openMooseReleaseWorkspace.
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

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion15 [

	(self project version: '1.5') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion16 [

	(self project version: '1.6') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion20 [

	(self project version: '2.0') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion21 [

	(self project version: '2.1') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion30 [

	(self project version: '3.0') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion40 [

	(self project version: '4.0') load.
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadVersion50 [

	(self project version: '5.0') load.
]

{ #category : #accessing }
ConfigurationOfMooseJEE class >> project [

	^self new project
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> refreshMooseCore [

	(self project version: 'refreshMooseCore') load.
	Smalltalk organization sortCategories.
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
ConfigurationOfMooseJEE >> baseline15: spec [ 
        <version: '1.5-baseline'>
        
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
			
		spec 
			"Extra Projects"
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard' with: [spec requires: 'Merlin'];
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline16: spec [ 
        <version: '1.6-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				"version: 'development';"
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
			
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.squeaksource.com/Moose' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.squeaksource.com/PetitJSParser' ].
		
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
			
		spec 
			"Extra Projects"
			package: 'Merlin' with: [spec repository: 'http://www.squeaksource.com/Merlin'];
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard' with: [spec requires: 'Merlin'];
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline20: spec [ 
        <version: '2.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.squeaksource.com/MooseJEE'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.squeaksource.com/MooseJEE' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
		
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				"version: 'default';"
				repository: 'http://www.squeaksource.com/Maze' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.squeaksource.com/Carrack' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline21: spec [ 
        <version: '2.1-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
		
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline30: spec [ 
        <version: '3.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
				
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.squeaksource.com/pagerank']; 
			package: 'RoassalGraphVizLayout' with: [spec repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal/main/']; 
		
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline40: spec [ 
        <version: '4.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main' ].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
				
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Pagerank/main']; 
			package: 'Roassal2GraphVizLayout'; 
		
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline50: spec [ 
        <version: '5.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
				
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Pagerank/main']; 
			package: 'Roassal2GraphVizLayout'; 
		
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline70: spec [ 
        <version: '7.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
				
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Pagerank/main']; 
			package: 'Roassal2GraphVizLayout'; 
		
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> baseline80: spec [ 
        <version: '8.0-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository:  'http://www.smalltalkhub.com/mc/FabrizioPerin/MooseEE/main'.
		
		spec  project: 'FAMIX SQL for MooseJEE' with: [
			spec
				className: 'ConfigurationOfFamixSQL';
				file: 'ConfigurationOfFamixSQL';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'].

		spec  project: 'PetitJSPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitJSPParser';
				file: 'ConfigurationOfPetitJSPParser';
				"version: 'development';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitJSPParser/main' ].
		
		spec  project: 'PetitPHPParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitPHPParser';
				file: 'ConfigurationOfPetitPHPParser';
				"version: 'defaultWithoutPetit';"
				repository: 'http://www.smalltalkhub.com/mc/Moose/PetitPHPParser/main'].
				
		spec  project: 'Maze for MooseJEE' with: [
			spec
				className: 'ConfigurationOfMaze';
				file: 'ConfigurationOfMaze';
				version: #development;
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main' ].

		spec  project: 'Carrack for MooseJEE' with: [
			spec
				className: 'ConfigurationOfCarrack';
				file: 'ConfigurationOfCarrack';
				"version: 'default';"
				repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main' ].
			
		spec 
			"Extra Projects"
			package: 'PageRank' with: [spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Pagerank/main']; 
			package: 'Roassal2GraphVizLayout'; 
		
			"Models"
			package: 'Moose-JEE-Core-Model';
			package: 'Moose-JEE-SQL-Model';
			package: 'Moose-JEE-JSP-Model';
			package: 'Moose-JEE-EJB-Model';
			package: 'Moose-JEE-Tiers-Model';
			package: 'Moose-JEE-Architecture-Model';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [spec requires: 'FAMIX SQL for MooseJEE'];
			package: 'Moose-JEE-Importers-JSP' with: [spec requires: 'PetitJSPParser for MooseJEE'];
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-EJBDraftObjs';
			package: 'Moose-JEE-Browsers' with: [spec requires: 'Moose-JEE-Core-Model'];
			package: 'Moose-JEE-Algos';
			package: 'Moose-JEE-Wizard';" with: [spec requires: 'Merlin'];"
			package: 'Moose-JEE-Help';
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources';
			package: 'Moose-JEE-Tests-Core' with: [spec requires: #('Moose-JEE-Core-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Algos' with: [spec requires: #('Moose-JEE-Algos' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-JSP' with: [spec requires: #('Moose-JEE-Importers-JSP' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Importers-SQL' with: [spec requires: #('Moose-JEE-Importers-SQL' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: [spec requires: #('Moose-JEE-EJBDraftObjs' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-SQL' with: [spec requires: #('Moose-JEE-SQL-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-JSP' with: [spec requires: #('Moose-JEE-JSP-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-EJB' with: [spec requires: #('Moose-JEE-EJB-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Extensions' with: [spec requires: #('Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Tiers' with: [spec requires: #('Moose-JEE-Tiers-Model' 'Moose-JEE-Tests-Resources')];
			package: 'Moose-JEE-Tests-Architecture-Model' with: [spec requires: #('Moose-JEE-Architecture-Model')].
			
	].
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
ConfigurationOfMooseJEE >> development: spec [
	<symbolicVersion: #development>

	spec for: #'pharo1.4.x' version: '1.6-baseline'.
	spec for: #'pharo2.x' version: '2.1'.
	spec for: #'pharo3.x' version: '3.0-baseline'.
	spec for: #'pharo4.x' version: '5.0-baseline'.
	spec for: #'pharo5.x' version: '5.0-baseline'.
	spec for: #'pharo7.x' version: '7.0-baseline'.
	spec for: #'pharo8.x' version: '8.0-baseline'.
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
ConfigurationOfMooseJEE >> refreshMooseCore: spec [
	"(self project version: 'refreshMooseCore') load."
	<version: 'refreshMooseCore'>
	spec
		for: #common
		do: [ 
			spec blessing: #development.	"Moose packages"
			spec repository: 'http://www.squeaksource.com/Moose'.
			
			spec project: 'MooseAlgos for Moose' with: [
				spec
					className: 'ConfigurationOfMooseAlgos';
					file: 'ConfigurationOfMooseAlgos';
					version: 'default';
					repository: 'http://www.squeaksource.com/MooseAlgos' ].
				
			spec project: 'Fame' with: [
				spec
					className: 'ConfigurationOfFame';
					version: 'default';
					file:  'ConfigurationOfFame';
					repository: 'http://www.squeaksource.com/Fame' ].
			spec
				package: 'Moose-Help';
				package: 'Moose-Core' with: [ spec requires: 'Fame' ];
				package: 'Famix-Specifications';
				package: 'Famix-Core' with: [ spec requires: #('Moose-Core') ];
				package: 'Famix-Implementation' with: [ spec requires: 'Famix-Core' ];
				package: 'Famix-Smalltalk'
					with: [ 
							spec file: 'Famix-Smalltalk-'.
							spec requires: 'Famix-Core' ];
				package: 'Famix-Java' with: [ spec requires: #('Famix-Core') ];
				package: 'Famix-C' with: [ spec requires: #('Famix-Core') ];
				package: 'Famix-Extensions' with: [ spec requires: #('Famix-Core' 'MooseAlgos for Moose') ];
				package: 'Famix-File' with: [ spec requires: #('Famix-Core' ) ];
				package: 'PetitMSE' with: [ spec repository: 'http://source.lukas-renggli.ch/petit' ];
				package: 'PetitJava' with: [ spec repository: 'http://www.squeaksource.com/PetitJava' ];
				package: 'PetitSmalltalk' with: [ spec repository: 'http://source.lukas-renggli.ch/petit' ];
				package: 'Moose-Hismo' with: [ spec requires: 'Moose-Core' ];
				package: 'Famix-SourceAnchor' with: [ spec requires: #('Famix-Core') ];
				package: 'Dynamix-Core'
					with: [ 
							spec repository: 'http://www.squeaksource.com/DynaMoose'.
							spec requires: 'Famix-Core' ];
				package: 'Moose-GenericImporter' with: [ spec requires: 'Moose-Core' ];
				package: 'Moose-SmalltalkImporter' with: [ spec requires: #('Moose-GenericImporter') ];
				package: 'Moose-MonticelloImporter' with: [ spec requires: #('Moose-SmalltalkImporter') ];
				package: 'Moose-Finder' with: [ spec requires: #('Famix-Extensions') ];
				package: 'Moose-Settings' with: [ spec requires: #('Moose-Finder') ];
				package: 'Moose-Wizard' with: [ spec requires: #('Moose-Finder') ];
				package: 'Arki-Reporter-Core' with: [ spec repository: 'http://www.squeaksource.com/Arki' ];
				package: 'Arki-Reporter-Browser'
					with: [ 
							spec repository: 'http://www.squeaksource.com/Arki'.
							spec requires: #('Arki-Reporter-Core' 'Moose-Finder') ];
				package: 'Arki-Tests-Reporter'
					with: [ 
							spec repository: 'http://www.squeaksource.com/Arki'.
							spec requires: #('Arki-Reporter-Core') ];
				package: 'Moose-Tests-Core' with: [ spec requires: 'Moose-Core' ];
				package: 'Famix-Tests-Core' with: [ spec requires: 'Moose-Tests-SmalltalkImporter-KGB' ];
				package: 'Famix-Tests-Java' with: [ spec requires: 'Moose-Tests-Core' ];
				package: 'Famix-Tests-C';
				package: 'Famix-Tests-Extensions';
				package: 'Dynamix-Tests-Core' with: [ spec repository: 'http://www.squeaksource.com/DynaMoose' ];
				package: 'Moose-Tests-Finder' with: [ spec requires: #('Moose-Finder' 'Famix-Tests-Java') ];
				package: 'MondrianGraphVizLayout' with: [ spec repository: 'http://www.squeaksource.com/Mondrian' ];
				package: 'Moose-MondrianPaintings'
					with: [ spec requires: #('MooseAlgos for Moose' 'Moose-Hismo' 'Famix-Extensions') ];
				package: 'Moose-Tests-MondrianPaintings' with: [ spec requires: #('Moose-MondrianPaintings') ];
				package: 'Moose-DistributionMap' with: [ spec requires: #('MooseAlgos for Moose') ];
				package: 'Moose-MultiDimensionsDistributionMap'
					with: [ spec requires: #( 'MooseAlgos for Moose') ];
				package: 'Moose-Tests-DistributionMap' with: [ spec requires: #('Moose-DistributionMap') ];
				package: 'Moose-EyeSeeCharts' with: [ spec requires: 'Moose-Core' ];
				package: 'Moose-Development-Tools';
				package: 'Moose-Tests-SmalltalkImporter-Core' with: [ spec requires: 'Moose-Tests-Core' ];
				package: 'Moose-TestResources-Reference-Core';
				package: 'Moose-TestResources-Reference-PackageOne';
				package: 'Moose-TestResources-Reference-PackageTwo' with: [ spec requires: 'Moose-Tests-SmalltalkImporter-Core' ];
				package: 'Moose-Tests-SmalltalkImporter-LAN' with: [ spec requires: 'Moose-Tests-Core' ];
				package: 'Moose-TestResources-LAN';
				package: 'Moose-Tests-SmalltalkImporter-KGB' with: [ spec requires: 'Moose-Tests-Core' ];
				package: 'Moose-TestResources-KGB-P4FullInteracted';
				package: 'Moose-TestResources-KGB-P6InteractedReferee';
				package: 'Moose-TestResources-KGB-P5FullReferee'
					with: [ spec requires: 'Moose-TestResources-KGB-P6InteractedReferee' ];
				package: 'Moose-TestResources-KGB-P1FullReferencer';
				package: 'Moose-TestResources-KGB-P2InteractedReferencerReferee'
					with: [ spec requires: 'Moose-TestResources-KGB-P5FullReferee' ];
				package: 'Moose-TestResources-KGB-P3InteractedReferencer';
				package: 'Moose-TestResources-KGB-P7ReferencerReferee';
				package: 'Moose-TestResources-KGB-P8FullReferencer'
					with: [ spec requires: 'Moose-TestResources-KGB-P7ReferencerReferee' ];
				package: 'Moose-TestResources-KGB-P9FullReferencer';
				package: 'Moose-TestResources-KGB-P10InteractedReferee';
				package: 'Moose-TestResources-KGB-P11FullReferee';
				package: 'Moose-TestResources-KGB-P12FullReferencer';
				package: 'Moose-TestResources-KGB-P13FullReferencer';
				package: 'Moose-TestResources-KGB-P14FullReferee';
				package: 'Moose-TestResources-KGB-PExtensions'
					with: [ spec requires: #('Moose-TestResources-KGB-P12FullReferencer' 'Moose-TestResources-KGB-P11FullReferee') ];
				package: 'Moose-TestResources-PackageBlueprint-P1';
				package: 'Moose-TestResources-PackageBlueprint-P2';
				package: 'Moose-TestResources-PackageBlueprint-P3';
				package: 'Moose-TestResources-PackageBlueprint-P4';
				package: 'Moose-Tests-MonticelloImporter' ]
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #common version: '4.0'.

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

{ #category : #baselines }
ConfigurationOfMooseJEE >> version15: spec [
	<version: '1.5' imports: #('1.5-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 1.5'.
		spec timestamp: '29/11/2012 16:00'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'FAMIX SQL for MooseJEE' with: 'default'.
		spec  project: 'PetitJSPParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'PetitPHPParser for MooseJEE' with: 'defaultWithoutPetit'.
		spec  project: 'Maze for MooseJEE' with: 'default'.
		
		spec
			package: 'Merlin' with: 'Merlin-AlexandreBergel.141';
			package: 'pagerank' with: 'PageRank-lr.6';
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: 'Moose-JEE-Core-Model-FabrizioPerin.22';
			package: 'Moose-JEE-SQL-Model' with: 'Moose-JEE-SQL-Model-FabrizioPerin.13';			
			package: 'Moose-JEE-JSP-Model' with: 'Moose-JEE-JSP-Model-FabrizioPerin.5';			
			package: 'Moose-JEE-EJB-Model' with: 'Moose-JEE-EJB-Model-FabrizioPerin.6';
			package: 'Moose-JEE-Tiers-Model' with: 'Moose-JEE-Tiers-Model-FabrizioPerin.11';
			package: 'Moose-JEE-Architecture-Model' with: 'Moose-JEE-Architecture-Model-FabrizioPerin.1';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.43';			
			package: 'Moose-JEE-Importers-JSP' with: 'Moose-JEE-Importers-JSP-FabrizioPerin.4';
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: 'Moose-JEE-Reports-FabrizioPerin.15';			
			package: 'Moose-JEE-EJBDraftObjs' with: 'Moose-JEE-EJBDraftObjs-FabrizioPerin.2';
			package: 'Moose-JEE-Browsers' with: 'Moose-JEE-Browsers-FabrizioPerin.5';
			package: 'Moose-JEE-Algos' with: 'Moose-JEE-Algos-FabrizioPerin.6';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.39';
			package: 'Moose-JEE-Help' with: 'Moose-JEE-Help-FabrizioPerin.2';			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: 'Moose-JEE-Tests-Resources-FabrizioPerin.9';
			package: 'Moose-JEE-Tests-Core' with: 'Moose-JEE-Tests-Core-FabrizioPerin.6';
			package: 'Moose-JEE-Tests-Algos' with: 'Moose-JEE-Tests-Algos-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-Importers-JSP' with: 'Moose-JEE-Tests-Importers-JSP-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-Importers-SQL' with: 'Moose-JEE-Tests-Importers-SQL-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: 'Moose-JEE-Tests-EJBDraftObjs-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-SQL' with: 'Moose-JEE-Tests-SQL-FabrizioPerin.16';			
			package: 'Moose-JEE-Tests-JSP' with: 'Moose-JEE-Tests-JSP-FabrizioPerin.2';
			package: 'Moose-JEE-Tests-EJB' with: 'Moose-JEE-Tests-EJB-FabrizioPerin.5';
			package: 'Moose-JEE-Tests-Extensions' with: 'Moose-JEE-Tests-Extensions-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Tiers' with: 'Moose-JEE-Tests-Tiers-FabrizioPerin.3';
			package: 'Moose-JEE-Tests-Architecture-Model' with: 'Moose-JEE-Tests-Architecture-Model-FabrizioPerin.1'.
			
		
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
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-Architecture-Model').			
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version16: spec [
	<version: '1.6' imports: #('1.6-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 1.6 for 1.4 but should also load on 2.0'.
		spec timestamp: '02/04/2013 14:00'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: 'development'.
		spec  project: 'FAMIX SQL for MooseJEE' with: 'development'.
		spec  project: 'PetitJSPParser for MooseJEE' with: 'development'.
		spec  project: 'PetitPHPParser for MooseJEE' with: 'development'.
		spec  project: 'Maze for MooseJEE' with: 'development'.
		
		spec
			package: 'Merlin' with: 'Merlin-AlexandreBergel.141';
			package: 'pagerank' with: 'PageRank-lr.6';
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: 'Moose-JEE-Core-Model-FabrizioPerin.22';
			package: 'Moose-JEE-SQL-Model' with: 'Moose-JEE-SQL-Model-FabrizioPerin.13';			
			package: 'Moose-JEE-JSP-Model' with: 'Moose-JEE-JSP-Model-FabrizioPerin.5';			
			package: 'Moose-JEE-EJB-Model' with: 'Moose-JEE-EJB-Model-FabrizioPerin.8';
			package: 'Moose-JEE-Tiers-Model' with: 'Moose-JEE-Tiers-Model-FabrizioPerin.11';
			package: 'Moose-JEE-Architecture-Model' with: 'Moose-JEE-Architecture-Model-FabrizioPerin.2';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.43';			
			package: 'Moose-JEE-Importers-JSP' with: 'Moose-JEE-Importers-JSP-FabrizioPerin.4';
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: 'Moose-JEE-Reports-FabrizioPerin.15';			
			package: 'Moose-JEE-EJBDraftObjs' with: 'Moose-JEE-EJBDraftObjs-FabrizioPerin.2';
			package: 'Moose-JEE-Browsers' with: 'Moose-JEE-Browsers-FabrizioPerin.5';
			package: 'Moose-JEE-Algos' with: 'Moose-JEE-Algos-FabrizioPerin.7';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.39';
			package: 'Moose-JEE-Help' with: 'Moose-JEE-Help-FabrizioPerin.2';			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: 'Moose-JEE-Tests-Resources-FabrizioPerin.9';
			package: 'Moose-JEE-Tests-Core' with: 'Moose-JEE-Tests-Core-FabrizioPerin.6';
			package: 'Moose-JEE-Tests-Algos' with: 'Moose-JEE-Tests-Algos-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Importers-JSP' with: 'Moose-JEE-Tests-Importers-JSP-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-Importers-SQL' with: 'Moose-JEE-Tests-Importers-SQL-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: 'Moose-JEE-Tests-EJBDraftObjs-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-SQL' with: 'Moose-JEE-Tests-SQL-FabrizioPerin.16';			
			package: 'Moose-JEE-Tests-JSP' with: 'Moose-JEE-Tests-JSP-FabrizioPerin.2';
			package: 'Moose-JEE-Tests-EJB' with: 'Moose-JEE-Tests-EJB-FabrizioPerin.5';
			package: 'Moose-JEE-Tests-Extensions' with: 'Moose-JEE-Tests-Extensions-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Tiers' with: 'Moose-JEE-Tests-Tiers-FabrizioPerin.3';
			package: 'Moose-JEE-Tests-Architecture-Model' with: 'Moose-JEE-Tests-Architecture-Model-FabrizioPerin.1'.
			
		
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
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-Architecture-Model').			
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version21: spec [
	<version: '2.1' imports: #('2.1-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 2.1 for Moose 4.9 on pharo 2.0'.
		spec timestamp: '04/03/2014 11:00'.
		
		spec  project: 'PetitSQLParser for MooseJEE' with: '2.0'.
		spec  project: 'FAMIX SQL for MooseJEE' with: '2.1'.
		spec  project: 'PetitJSPParser for MooseJEE' with: '1.1'.
		spec  project: 'PetitPHPParser for MooseJEE' with: '1.1'.
		spec  project: 'Maze for MooseJEE' with: '2.0'.
		
		spec
			package: 'Merlin' with: 'Merlin-AlexandreBergel.141';
			package: 'pagerank' with: 'PageRank-lr.6';
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: 'Moose-JEE-Core-Model-FabrizioPerin.38';
			package: 'Moose-JEE-SQL-Model' with: 'Moose-JEE-SQL-Model-FabrizioPerin.14';			
			package: 'Moose-JEE-JSP-Model' with: 'Moose-JEE-JSP-Model-FabrizioPerin.5';			
			package: 'Moose-JEE-EJB-Model' with: 'Moose-JEE-EJB-Model-FabrizioPerin.10';
			package: 'Moose-JEE-Tiers-Model' with: 'Moose-JEE-Tiers-Model-FabrizioPerin.18';
			package: 'Moose-JEE-Architecture-Model' with: 'Moose-JEE-Architecture-Model-FabrizioPerin.5';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.44';			
			package: 'Moose-JEE-Importers-JSP' with: 'Moose-JEE-Importers-JSP-FabrizioPerin.4';
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: 'Moose-JEE-Reports-FabrizioPerin.15';			
			package: 'Moose-JEE-EJBDraftObjs' with: 'Moose-JEE-EJBDraftObjs-FabrizioPerin.2';
			package: 'Moose-JEE-Browsers' with: 'Moose-JEE-Browsers-FabrizioPerin.5';
			package: 'Moose-JEE-Algos' with: 'Moose-JEE-Algos-FabrizioPerin.7';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.42';
			package: 'Moose-JEE-Help' with: 'Moose-JEE-Help-FabrizioPerin.2';			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: 'Moose-JEE-Tests-Resources-FabrizioPerin.9';
			package: 'Moose-JEE-Tests-Core' with: 'Moose-JEE-Tests-Core-FabrizioPerin.6';
			package: 'Moose-JEE-Tests-Algos' with: 'Moose-JEE-Tests-Algos-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Importers-JSP' with: 'Moose-JEE-Tests-Importers-JSP-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-Importers-SQL' with: 'Moose-JEE-Tests-Importers-SQL-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: 'Moose-JEE-Tests-EJBDraftObjs-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-SQL' with: 'Moose-JEE-Tests-SQL-FabrizioPerin.17';			
			package: 'Moose-JEE-Tests-JSP' with: 'Moose-JEE-Tests-JSP-FabrizioPerin.2';
			package: 'Moose-JEE-Tests-EJB' with: 'Moose-JEE-Tests-EJB-FabrizioPerin.5';
			package: 'Moose-JEE-Tests-Extensions' with: 'Moose-JEE-Tests-Extensions-FabrizioPerin.11';
			package: 'Moose-JEE-Tests-Tiers' with: 'Moose-JEE-Tests-Tiers-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-Architecture-Model' with: 'Moose-JEE-Tests-Architecture-Model-FabrizioPerin.1'.
			
		
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
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-Architecture-Model').			
		].
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> version40: spec [
	<version: '4.0' imports: #('4.0-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 4.0 for Moose 6 on pharo 5.0'.
		spec timestamp: '28/07/2015 11:00'.
		spec  project: 'FAMIX SQL for MooseJEE' with: '4.1'.
		spec  project: 'PetitJSPParser for MooseJEE' with: '1.1'.
		spec  project: 'PetitPHPParser for MooseJEE' with: '1.1'.
		spec  project: 'Maze for MooseJEE' with: '3.0'.
		
		spec
			package: 'Merlin' with: 'Merlin-AlexandreBergel.141';
			package: 'pagerank' with: 'PageRank-lr.6';
			
			"Models"
			package: 'Moose-JEE-Core-Model' with: 'Moose-JEE-Core-Model-FabrizioPerin.38';
			package: 'Moose-JEE-SQL-Model' with: 'Moose-JEE-SQL-Model-FabrizioPerin.14';			
			package: 'Moose-JEE-JSP-Model' with: 'Moose-JEE-JSP-Model-FabrizioPerin.5';			
			package: 'Moose-JEE-EJB-Model' with: 'Moose-JEE-EJB-Model-FabrizioPerin.10';
			package: 'Moose-JEE-Tiers-Model' with: 'Moose-JEE-Tiers-Model-FabrizioPerin.18';
			package: 'Moose-JEE-Architecture-Model' with: 'Moose-JEE-Architecture-Model-FabrizioPerin.5';
						
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: 'Moose-JEE-Importers-SQL-FabrizioPerin.44';			
			package: 'Moose-JEE-Importers-JSP' with: 'Moose-JEE-Importers-JSP-FabrizioPerin.4';
			
			"Other utils"
			package: 'Moose-JEE-Reports' with: 'Moose-JEE-Reports-FabrizioPerin.15';			
			package: 'Moose-JEE-EJBDraftObjs' with: 'Moose-JEE-EJBDraftObjs-FabrizioPerin.2';
			package: 'Moose-JEE-Browsers' with: 'Moose-JEE-Browsers-FabrizioPerin.5';
			package: 'Moose-JEE-Algos' with: 'Moose-JEE-Algos-FabrizioPerin.7';
			package: 'Moose-JEE-Wizard' with: 'Moose-JEE-Wizard-FabrizioPerin.42';
			package: 'Moose-JEE-Help' with: 'Moose-JEE-Help-FabrizioPerin.2';			
			
			"Tests"
			package: 'Moose-JEE-Tests-Resources' with: 'Moose-JEE-Tests-Resources-FabrizioPerin.9';
			package: 'Moose-JEE-Tests-Core' with: 'Moose-JEE-Tests-Core-FabrizioPerin.6';
			package: 'Moose-JEE-Tests-Algos' with: 'Moose-JEE-Tests-Algos-FabrizioPerin.8';
			package: 'Moose-JEE-Tests-Importers-JSP' with: 'Moose-JEE-Tests-Importers-JSP-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-Importers-SQL' with: 'Moose-JEE-Tests-Importers-SQL-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-EJBDraftObjs' with: 'Moose-JEE-Tests-EJBDraftObjs-FabrizioPerin.1';
			package: 'Moose-JEE-Tests-SQL' with: 'Moose-JEE-Tests-SQL-FabrizioPerin.17';			
			package: 'Moose-JEE-Tests-JSP' with: 'Moose-JEE-Tests-JSP-FabrizioPerin.2';
			package: 'Moose-JEE-Tests-EJB' with: 'Moose-JEE-Tests-EJB-FabrizioPerin.5';
			package: 'Moose-JEE-Tests-Extensions' with: 'Moose-JEE-Tests-Extensions-FabrizioPerin.11';
			package: 'Moose-JEE-Tests-Tiers' with: 'Moose-JEE-Tests-Tiers-FabrizioPerin.7';
			package: 'Moose-JEE-Tests-Architecture-Model' with: 'Moose-JEE-Tests-Architecture-Model-FabrizioPerin.1'.
			
		
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
			'Moose-JEE-Tests-Algos'
			'Moose-JEE-Tests-Architecture-Model').			
		].
]
