Class {
	#name : #MJFAMIXTableTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testInUse [
	| mooseModel annotationType jEETestModel root table1 annotationTypeColumn famixAnchor maps |

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

	self assert: (mooseModel allColumns size = 6).
	
	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: MJFAMIXTable]).

	self assert: (maps size = 1).

	self assert: (maps anySatisfy: [:map | map mapTarget name = #Table1 and: [map mapTarget inUse]]).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameWithAnnotationAsRegex [
	| mooseModel annotationType jEETestModel root table1 annotationTypeColumn famixAnchor maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.

						
	"adding a fake sourceText to the Entities"
	
	self assert: (mooseModel allTables size = 3).
	self assert: (table1 nameWithAnnotationAsRegex matches: jEETestModel fakeSourceText).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testTableGroup [
	| mooseModel annotationType jEETestModel root table1 annotationTypeColumn famixAnchor maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	
	mooseModel openInMoose.
]
