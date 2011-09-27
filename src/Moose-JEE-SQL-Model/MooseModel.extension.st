Extension { #name : #MooseModel }

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allColumns [
	<navigation: 'All Table Columns'>
	
	| group |
	
	
	group := self allWithType: MJFAMIXColumn ofGroupClass: MJFAMIXColumnGroup.
	group description: 'All Table Columns'.
	^group
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allDBAccesses [
	<navigation: 'All DB accessses'>

	| group |
	
	group :=  self allWithType: MJFAMIXDBAccess.
	group description: 'All DB accessses'.
	^group
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allDatabases [

	^self allWithType: MJFAMIXDataBase "asMetaDescription"
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allFKAssociations [
	<navigation: 'All FK associations'>

	| group |
	
	group :=  self allWithType: MJFAMIXFKAssociation ofGroupClass: MJFAMIXFKAssociationGroup.
	group description: 'All FK associations'.
	^group
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allMaps [
	<navigation: 'All Maps'>

	| group |
	
	group :=  self allWithType: MJFAMIXMapping ofGroupClass: MJFAMIXMappingGroup.
	group description: 'All Maps'.
	^group
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> allTables [
	<navigation: 'All Data Base Tables'>
	
	| group |
	
	group :=  self allWithType: MJFAMIXTable ofGroupClass: MJFAMIXTableGroup.
	group description: 'All Data Base Tables'.
	^group
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> buildMappingBetweenSoftwareEntityAndRelationalElements [
	<menuItem: 'Build mapping between relational entity and source code entity' category: 'JEAs Importers'>
	
	|  question strategy |

	strategy := UITheme builder chooseDropList: 'Choose the method to use for the mapping ' list: ((MJMappingStrategy methods reject: [:each | each category = #initialization ]) collect: [:method | method selector asString]).
	
	strategy isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			(MJMappingStrategy on: self) perform: strategy asSymbol ].
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> cleanUpAllMaps [
	
	self withoutAnnounceRemoveAll: (self allWithType: MJFAMIXMapping).
	self allClasses do: [:class | class removePointersToMaps ].
	self allTables do: [:table | table removePointersToMaps ]
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> cleanUpAllMapsGUI [
	<menuItem: 'Clean up all maps' category: 'JEAs Utilities'>
	
	|  question strategy |

	question := UITheme builder questionWithoutCancel: 'Do you want to clean up previously created maps?'.
	question ifTrue: [self cleanUpAllMaps].
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> cleanUpDuplicatedMaps [
	<menuItem: 'Clean up duplicated maps' category: 'JEAs Utilities'>
	
	| maps toRemove |
	
	maps := self allMaps.
	toRemove := OrderedCollection new.
	
	(1 to: maps size) do: [:firstMapIndex |
		((firstMapIndex + 1) to: maps size) do: [:secondMapIndex |
			((maps at: firstMapIndex) mapSource = (maps at: secondMapIndex) mapSource) ifTrue: [
				((maps at: firstMapIndex) mapTarget = (maps at: secondMapIndex) mapTarget) ifTrue: [
					toRemove add: (maps at: secondMapIndex) ]]]].
	
	self withoutAnnounceRemoveAll: toRemove asSet.  
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> importDBFromSQLFileUsingAST: aFileStream [
	
	| parser result ejbVer |

	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
			| importer |
			
			bar value: 2.
			bar value: 'Parsing SQL file'.
			importer := MJSQLImporterFromVisitor new targetModel: self.
			importer importSQLCreateScriptFrom: ([ aFileStream contentsOfEntireFile ]
																				ensure: [ aFileStream close ]).
			
			"bar value: 3.
			bar value: 'Populate the model'.
			self populateWithRelationalElementsFrom: parser blackBoard."
			
			"self ejbVersion isNil 
				ifTrue: [
					ejbVer := UITheme builder 
								chooseDropList: 'Choose the ejb type' list: #(#'EJB21' #'EJB30').
					self ejbVersion: ejbVer.]."

			bar value: 4.
			bar value: 'Building relations'.
			
			"self buildRelationsAmongDBTablesAndClasses.			
			self buildRelationsAmongTableColumnsAndMethods."
			
			bar value: 5].
	^self
]

{ #category : #'*moose-jee-sql-model' }
MooseModel >> importDBFromSQLFileUsingASTGUI [
	<menuItem: 'Import database from SQL file using AST' category: 'JEAs Importers'>
	
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[self importDBFromSQLFileUsingAST: file readStream].
]
