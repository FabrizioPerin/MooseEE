Class {
	#name : #ConfigurationOfMooseJEE,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseJEE
}

{ #category : #private }
ConfigurationOfMooseJEE class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfMooseJEE class >> ensureMetacello [
	"Minimum package versions from which to boot Metacello. Corresponds to version 1.0-beta.4"

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Minimum version of Gofer from which to bootstrap"
			self bootstrapPackage: 'Gofer-lr.67' from: 'http://source.lukas-renggli.ch/flair' ].
		Smalltalk at: #Gofer ifPresent: [:gofer |
			gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				addVersion: 'Metacello-Core-dkh.273'; "Minimum version from which to bootstrap Metacello"
				addVersion: 'Metacello-MC-dkh.205'; "Minimum version from which to bootstrap Metacello"
				addPackage: 'Metacello-Configuration'; "Loads latest version of configuration package"
				load ].
		"load latest version of Metacello, load a specific version if desired"
		((Smalltalk at: #MetacelloConfiguration) project latestVersion) load: 'UI' ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseJEE class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseJEE class >> loadDefault [
	(self project version: 'default') load
]

{ #category : #accessing }
ConfigurationOfMooseJEE class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseJEE >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec 
			package: 'Moose-JEE' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				"spec requires: 'Moose for MooseJEE'"];
			package: 'XML-Parser' with: [
				spec repository: 'http://www.squeaksource.com/XMLSupport'];
			package: 'Opax' with: [
				spec repository: 'http://www.squeaksource.com/OPAX'.
				spec requires: 'XML-Parser'];
			package: 'PEGSQLParser' with: [spec repository: 'http://www.squeaksource.com/PEGSQLParser'].
		"spec project: 'Moose for MooseJEE' with: [
				spec
					className: 'ConfigurationOfMoose';
					file: 'ConfigurationOfMoose';
					version: 'default';
					repository: 'http://www.squeaksource.com/Moose' ]."
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
