Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-sql' }
MooseModel >> buildMappingBetweenSoftwareEntityAndRelationalElements [
	<menuItem: 'Build mapping between relational entity and source code entity' category: 'JEAs Importers'>
	
	|  question strategy |

	strategy := UITheme builder chooseDropList: 'Choose the method to use for the mapping ' list: ((MJMappingStrategy methods reject: [:each | each category = #initialization ]) collect: [:method | method selector asString]).
	
	strategy isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			(MJMappingStrategy on: self) perform: strategy asSymbol ].
]

{ #category : #'*moose-jee-importers-sql' }
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

{ #category : #'*moose-jee-importers-sql' }
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
