Class {
	#name : #MJFAMIXMappingTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #testsOnJEEModel }
MJFAMIXMappingTests >> testFAMIXMappingCreation [
	
	| mooseModel  class table map mapping jEETestModel root |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.
	
	(root allChildren select: [:each | each class = EntityElement]) do: [:each | each populate: mooseModel].
	
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
		
	mapping := MJFAMIXMapping new mapTarget: table; mapSource: class.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mooseModel add: mapping.
	
	self assert: (mooseModel allMaps size = 1).
	
	map := (mooseModel allMaps select: [:each | each from = class and: [each to = table]]).
	self assert: map size = 1.

]

{ #category : #testsOnJEEModel }
MJFAMIXMappingTests >> testFAMIXMappingModelColumnsPopulation [
	| mooseModel annotationType famixAnchor entities tables jEETestModel root annotationTypeColumn columns table1 |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	"define Entity beans"
	(root allChildren select: [:each | each class = EntityElement]) do: [:each | each populate: mooseModel].
	
	"Creating the annotation type Table"
	annotationType := FAMIXAnnotationType new name: #Table.
	mooseModel add: annotationType.
	
	annotationTypeColumn := FAMIXAnnotationType new name: #Column.
	mooseModel add: annotationTypeColumn.
	
	"Creating the Table instances"
	mooseModel allEntityBeans  do: [:bean | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationType.
							instance annotatedEntity: bean implementationClass.
							mooseModel add: instance.
							 ].
						
	"Creating the Columns instances"
	mooseModel allEntityBeans do: [:bean | 
			bean implementationClass attributes do: [:attr |
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationTypeColumn.
							instance annotatedEntity: attr.
							mooseModel add: instance.
							 ]].
						
	"adding a fake sourceText to the Entities"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	mooseModel allEntityBeans first implementationClass sourceAnchor: famixAnchor.
	
	mooseModel buildRelationsAmongDBTablesAndClasses.
	mooseModel buildRelationsAmongTableColumnsAndMethods.

	entities := mooseModel allEntityBeans.
	tables := mooseModel allTables.
	columns := mooseModel allColumns.


	self assert: (entities size = 2).
	self assert: (tables size = 3).
	self assert: (columns size = 6).
	
	self assert: ((mooseModel allMaps select: [:each | each mapTarget isKindOf: MJFAMIXColumn]) size = 3).
	"FARE VERIFICA DEI TIPI"
	
]

{ #category : #testsOnJEEModel }
MJFAMIXMappingTests >> testFAMIXMappingModelPopulation [
	| mooseModel annotationType famixAnchor entities tables jEETestModel root |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	
	"define Entity beans"
	(root allChildren select: [:each | each class = EntityElement]) do: [:each | each populate: mooseModel].
	
	"Creating the annotation type Table"
	annotationType := FAMIXAnnotationType new name: #Table.
	mooseModel add: annotationType.
	
	"Creating the instances"
	mooseModel allEntityBeans do: [:bean | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationType.
							instance annotatedEntity: bean.
							mooseModel add: instance.
							 ].
						
	"adding a fake sourceText to the Entities"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	mooseModel allEntityBeans first sourceAnchor: famixAnchor.

	mooseModel buildRelationsAmongDBTablesAndClasses.
	

	entities := mooseModel allEntityBeans.
	tables := mooseModel allTables.


	self assert: (entities size = 2).
	self assert: (tables size = 3).
	
	self assert: (mooseModel allMaps size = 1).
	
]
