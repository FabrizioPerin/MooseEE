Class {
	#name : #MapTablesOnInterfacesByNameTests,
	#superclass : #TestCase,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnInterfacesByNameTests >> testBuildMapsOn [
	| jEETestModel mooseModel maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDBTablesNamedAsInterfaces.
	mooseModel ejbVersion: #EJB30.
	
	MapTablesOnInterfacesByName new buildMapsOn: mooseModel.

	maps := mooseModel allMaps.
	
	self assert: (maps size = 2).
	
	self assert: (maps anySatisfy: [:map | map mapTarget name = #ACMPEntityBean]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #ABMPEntityBean]).
]
