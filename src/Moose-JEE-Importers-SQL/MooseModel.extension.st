Extension { #name : #MooseModel }

{ #category : #'*moose-jee-importers-sql' }
MooseModel >> buildMappingBetweenSoftwareEntityAndRelationalElements [
	"<menuItem: 'Build mapping between relational entity and source code entity' category: 'JEAs Importers'>"
	
	|  question strategy |
	self deprecated: 'Use mapSoftwareEntityOnRelationalElements method or "Map source code entities on relational entities" UI entry instead'.
	
	strategy := UITheme builder chooseDropList: 'Choose the method to use for the mapping ' list: ((MJMappingStrategy methods reject: [:each | each category = #initialization ]) collect: [:method | method selector asString]).
	
	strategy isNil 
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.']
		ifFalse: [
			(MJMappingStrategy on: self) perform: strategy asSymbol ].
]

{ #category : #'*moose-jee-importers-sql' }
MooseModel >> mapSoftwareEntityOnRelationalElements [
	<menuItem: 'Map source code entities on relational entities' category: 'JEAs Importers'>
	| question strategyName |

	strategyName := UITheme builder
		chooseDropList: 'Choose the method to use for the mapping '
		list:
			((MJMappingStrategy allSubclasses)
				collect: [ :class | class name removeSuffix: ' class' ]).

	strategyName isNil
		ifTrue: [ DialogWindow new alert: 'Strategy not selected, operation aborted.' ]
		ifFalse: [((Smalltalk at: strategyName) perform: #new) buildMapsOn: self]
]
