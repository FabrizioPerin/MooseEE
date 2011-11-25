Extension { #name : #FAMIXColumnTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXColumnTests >> testInUseCaseInsensitive [
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
	mooseModel allEntityBeans do: [:bean | 
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
	mooseModel allEntityBeans do: [:bean | 
			bean implementationClass sourceAnchor: famixAnchor.].
	
	mooseModel allAttributes do: [:attr |
		attr name = 'Att1' ifTrue: [attr declaredType: (FAMIXClass new	name: 'WorkUnitAuthOperation'; yourself)].
		attr name = 'Att2' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].
		attr name = 'Att3' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].].
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	(MJMappingStrategy on: mooseModel) buildRelationsAmongTableColumnsAndMethodsAndAttributes.

	self assert: (mooseModel allColumns size = 6).

	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]).

	self assert: (maps size = 3).
		
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column2 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column4 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column6 and: [map mapTarget inUse]]).

]

{ #category : #'*moose-jee-tests-sql' }
FAMIXColumnTests >> testIsUniqueFromAModel [
	| jEETestModel mooseModel table1 |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).

	self assert: ((table1 columns select: [:each | each name = #Column4 ]) first isUnique).
	self deny: ((table1 columns select: [:each | each name = #Column6 ]) first isUnique).
]
