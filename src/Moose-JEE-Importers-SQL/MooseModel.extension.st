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
