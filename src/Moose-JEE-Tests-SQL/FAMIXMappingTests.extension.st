Extension { #name : #FAMIXMappingTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testFAMIXMappingModelColumnsPopulation [
	| mooseModel annotationType jEETestModel root table1 annotationTypeColumn famixAnchor maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	"define Entity beans"
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
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
	mooseModel allAttributes do: [:attr |
		attr name = 'Att1' ifTrue: [attr declaredType: (FAMIXClass new	name: 'WorkUnitAuthOperation'; yourself)].
		attr name = 'Att2' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].
		attr name = 'Att3' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].].
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	(MJMappingStrategy on: mooseModel) buildRelationsAmongTableColumnsAndMethodsAndAttributes.

	self assert: (mooseModel allEntityBeans size = 2).
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allColumns size = 6).
	
	self assert: ((mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]) size = 3).
	
	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]).
	
	self assert: (maps anySatisfy: [:map | (map mapTarget name = #Column6) and: [map mapSource name = 'Att3']]).
	self assert: (maps anySatisfy: [:map | (map mapTarget name  = #Column4) and: [map mapSource name = 'Att2']]).
	self assert: (maps anySatisfy: [:map | (map mapTarget name = #Column2) and: [map mapSource name = 'Att1']]).
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testFAMIXMappingModelColumnsPopulationCaseInsensitive [
	| mooseModel annotationType jEETestModel root table1 annotationTypeColumn famixAnchor maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	"define Entity beans"
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
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
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceTextWithLowerCaseNames.
	mooseModel allEntityBeans first implementationClass sourceAnchor: famixAnchor.
	mooseModel allAttributes do: [:attr |
		attr name = 'Att1' ifTrue: [attr declaredType: (FAMIXClass new	name: 'WorkUnitAuthOperation'; yourself)].
		attr name = 'Att2' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].
		attr name = 'Att3' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].].
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	(MJMappingStrategy on: mooseModel) buildRelationsAmongTableColumnsAndMethodsAndAttributes.

	self assert: (mooseModel allEntityBeans size = 2).
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allColumns size = 6).
	
	self assert: ((mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]) size = 3).
	
	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]).
	
	self assert: (maps anySatisfy: [:map | (map mapTarget name = #Column6) and: [map mapSource name = 'Att3']]).
	self assert: (maps anySatisfy: [:map | (map mapTarget name  = #Column4) and: [map mapSource name = 'Att2']]).
	self assert: (maps anySatisfy: [:map | (map mapTarget name = #Column2) and: [map mapSource name = 'Att1']]).
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testFAMIXMappingModelPopulation [
	| mooseModel annotationType famixAnchor jEETestModel root |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	
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

	self assert: (mooseModel allEntityBeans size = 2).
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allMaps size = 1).
	
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testFAMIXMappingModelPopulationCaseInsensitive [
	| mooseModel annotationType famixAnchor jEETestModel root |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.
	root := jEETestModel root.
	
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
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceTextWithLowerCaseNames .
	mooseModel allEntityBeans first sourceAnchor: famixAnchor.

	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.

	self assert: (mooseModel allEntityBeans size = 2).
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allMaps size = 1).
	
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testMappedNamedEntities [
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

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testMappedNamedEntitiesCaseInsensitive [
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

{ #category : #'*moose-jee-tests-sql' }
FAMIXMappingTests >> testPrintOn [
	
	| mooseModel  class table map mapping jEETestModel root stream res |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	root := jEETestModel root.
	
	(root allElements  select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	
	mapping := FAMIXMapping new mapTarget: table; mapSource: class.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mooseModel add: mapping.
	
	self assert: (mooseModel allMaps size = 1).
	
	map := (mooseModel allMaps select: [:each | each from = class and: [each to = table]]) first.
	
	stream := ReadWriteStream on: ''.
	map printOn: stream.
	
	self assert: (stream contents = (map mapSource name asString , ' -> ' , map mapTarget name asString , ' (Maps)')).

]
