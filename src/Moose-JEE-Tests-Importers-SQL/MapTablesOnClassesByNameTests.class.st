Class {
	#name : #MapTablesOnClassesByNameTests,
	#superclass : #TestCase,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnClassesByNameTests >> testBuildMapsOn [
	| jEETestModel mooseModel maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDBTablesNamedAsClasses.
	mooseModel ejbVersion: #EJB30.
	
	"adding a fake sourceText to the Entities"
"	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	classesWithAnnotations do: [:bean | 
			bean sourceAnchor: famixAnchor.].
"	
	MapTablesOnClassesByName new buildMapsOn: mooseModel.

	maps := mooseModel allMaps.
	
	self assert: (maps size = 2).
	
	self assert: (maps anySatisfy: [:map | map mapTarget name = #ACMPEntityBean]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #ABMPEntityBean]).
]
