Class {
	#name : #MJFAMIXRelationalEntityTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testAnnotation [
	self assert: MJFAMIXRelationalEntity annotation == MJFAMIXRelationalEntity.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testBelongsTo [
	self assert: MJFAMIXRelationalEntity new belongsTo = ''.
]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testMappedNamedEntities [
	| mooseModel annotationType famixAnchor entities table1 aCMPEntity root jEETestModel |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.

	mooseModel ejbVersion: #EJB30.	
	"define Entity beans"
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (table1 mappedNamedEntities size = 1).
	self assert: (table1 mappedNamedEntities first = aCMPEntity ).

]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testMappedNamedEntitiesCaseInsensitive [
	| mooseModel annotationType famixAnchor entities table1 aCMPEntity root jEETestModel |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.

	mooseModel ejbVersion: #EJB30.	
	"define Entity beans"
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
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
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceTextWithLowerCaseNames.
	mooseModel allEntityBeans first sourceAnchor: famixAnchor.
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (table1 mappedNamedEntities size = 1).
	self assert: (table1 mappedNamedEntities first = aCMPEntity ).

]

{ #category : #tests }
MJFAMIXRelationalEntityTests >> testSourceAccessors [
	
	| table dbAccess |
	
	table := MJFAMIXTable new name: #Table1.
	
	dbAccess := MJFAMIXDBAccess new accessedEntity: table.
	
	table addSourceAccessors: dbAccess.
	
	self assert: (table isMemberOf: MJFAMIXTable).

	self assert: (table sourceAccessors isMemberOf: FMMultivalueLink).
	self assert: (table sourceAccessors first = dbAccess).
	self assert: (table sourceAccessors first to = table).
]
