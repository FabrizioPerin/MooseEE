Class {
	#name : #FAMIXNamedEntityMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testMappedRelationalEntities [
	| mooseModel root jEETestModel annotationType famixAnchor aCMPEntity table1 |

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
	
	mooseModel buildRelationsAmongDBTablesAndClasses.
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (aCMPEntity mappedRelationalEntities size = 1).
	self assert: (aCMPEntity mappedRelationalEntities first = table1 ).
	
	

]

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testMappedRelationalEntitiesCaseInsensitive [
	| mooseModel root jEETestModel annotationType famixAnchor aCMPEntity table1 |

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
	
	mooseModel buildRelationsAmongDBTablesAndClasses.
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (aCMPEntity mappedRelationalEntities size = 1).
	self assert: (aCMPEntity mappedRelationalEntities first = table1 ).
	
	

]
