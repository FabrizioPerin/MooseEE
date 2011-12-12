Class {
	#name : #MapTablesOnClassesUsingAnnotationsTests,
	#superclass : #TestCase,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapTablesOnClassesUsingAnnotationsTests >> testBuildMapsOn [
	

	| jEETestModel mooseModel table1 annotationType classesWithAnnotations famixAnchor maps |
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	"Creating the annotation type Table"
	annotationType := FAMIXAnnotationType new name: #Table.
	mooseModel add: annotationType.
	
	"Creating the Table instances"
	classesWithAnnotations := mooseModel allClasses select: [:each | (each name = #ACMPEntityBean) or:[each name = #ABMPEntityBean]].
	classesWithAnnotations do: [:class | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationType.
							instance annotatedEntity: class.
							mooseModel add: instance.
							 ].

	"adding a fake sourceText to the Entities"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	classesWithAnnotations do: [:bean | 
			bean sourceAnchor: famixAnchor.].
	
	MapTablesOnClassesUsingAnnotations new buildMapsOn: mooseModel.

	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXTable]).

	self assert: (maps size = 2).		
	self assert: (maps allSatisfy: [:map | map mapTarget name = #Table1]).
]
