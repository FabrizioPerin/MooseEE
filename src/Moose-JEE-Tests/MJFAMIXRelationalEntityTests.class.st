Class {
	#name : #MJFAMIXRelationalEntityTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testMappedNamedEntities [
	| mooseModel annotationType famixAnchor entities table1 aCMPEntity root jEETestModel |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.

	mooseModel ejbVersion: #EJB30.	
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
	
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (table1 mappedNamedEntities size = 1).
	self assert: (table1 mappedNamedEntities first = aCMPEntity ).

]
