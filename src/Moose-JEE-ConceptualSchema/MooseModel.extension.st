Extension { #name : #MooseModel }

{ #category : #'*moose-jee-conceptualschema' }
MooseModel >> importDBStructureConceptualSchemaCustomFrom: aFileStream [
	
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
			importer := MJCSSQLImporter new targetModel: self.
			importer importSQLCreateScriptFrom: ([ aFileStream contentsOfEntireFile ]
																				ensure: [ aFileStream close ]).
			
			bar value: 4.
			bar value: 'Building relations'.
			
			bar value: 5].
	^self
]
