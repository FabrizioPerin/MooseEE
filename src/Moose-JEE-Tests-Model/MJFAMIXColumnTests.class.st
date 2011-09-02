Class {
	#name : #MJFAMIXColumnTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXColumnTests >> testAnnotation [
	self assert: MJFAMIXColumn annotation == MJFAMIXColumn.
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testCanBeNull [
	| col |

	col := MJFAMIXColumn new
					name: #Column2;
					canBeNull: true.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: col canBeNull.  
	
	col canBeNull: false.
	
	self deny: col canBeNull.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testCanBeNullFromAModel [
	| jEETestModel mooseModel table1 |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	
	self deny: ((table1 columns select: [:each | each name = #Column2 ]) first canBeNull).
	self deny: ((table1 columns select: [:each | each name = #Column2 ]) first canBeNull).
	self assert: ((table1 columns select: [:each | each name = #Column4 ]) first canBeNull).
	self deny: ((table1 columns select: [:each | each name = #Column6 ]) first canBeNull).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testCreation [
	| col |
	
	col := MJFAMIXColumn new
					name: #Column2..
					
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testDefaultValue [
	| col |

	col := MJFAMIXColumn new
					name: #Column2;
					defaultValue: 0.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col defaultValue = 0).  
	
	col defaultValue: 'isAString'.
	
	self assert: col defaultValue = 'isAString'.
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testInUse [
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
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceTextWithLowerCaseNames.
	mooseModel allEntityBeans do: [:bean | 
			bean implementationClass sourceAnchor: famixAnchor.].
	
	mooseModel allAttributes do: [:attr |
		attr name = 'Att1' ifTrue: [attr declaredType: (FAMIXClass new	name: 'WorkUnitAuthOperation'; yourself)].
		attr name = 'Att2' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].
		attr name = 'Att3' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].].
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	(MJMappingStrategy on: mooseModel) buildRelationsAmongTableColumnsAndMethodsAndAttributes.

	self assert: (mooseModel allColumns size = 6).

	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: MJFAMIXColumn]).

	self assert: (maps size = 3).
		
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column2 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column4 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column6 and: [map mapTarget inUse]]).

]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testInUseCaseInsensitive [
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

	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: MJFAMIXColumn]).

	self assert: (maps size = 3).
		
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column2 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column4 and: [map mapTarget inUse]]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column6 and: [map mapTarget inUse]]).

]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testIsFK [
	| col |

	col := MJFAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col isFK isNil).  
	
	col isFK: true.
	
	self assert: (col isFK).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testIsPK [
	| col |

	col := MJFAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col isPK isNil).  
	
	col isPK: true.
	
	self assert: (col isPK).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testIsUnique [
	| col |

	col := MJFAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col isUnique isNil).  
	
	col isUnique: true.
	
	self assert: (col isUnique).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testIsUniqueFromAModel [
	| jEETestModel mooseModel table1 |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).

	self assert: ((table1 columns select: [:each | each name = #Column4 ]) first isUnique).
	self deny: ((table1 columns select: [:each | each name = #Column6 ]) first isUnique).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testMJFAMIXColumnCreateAll [
	| col |

	col := MJFAMIXColumn new
					name: #Column2;
					isPK: true;
					isFK: false;
					ownerTable:  (MJFAMIXTable new name: #tab1);
					canBeNull: false;
					type: 'integer'.
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: col isPK.
	self deny: col isFK.
	self deny: col canBeNull.
	self assert: (col type = 'integer').            
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testMJFAMIXColumnCreation [
	| col |

	col := MJFAMIXColumn new name: #Column2.  
	
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testOwnerTable [
	| mooseModel annotationType jEETestModel table1 annotationTypeColumn famixAnchor maps |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	self assert: (table1 columns allSatisfy: [:column | column ownerTable = table1]).
	
	"Clean up the references with the table"
	table1 columns do: [:column | column ownerTable: nil].
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	self assert: (table1 columns allSatisfy: [:column | column ownerTable = nil]).
]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testPrintOn [
	| col stream |
	
	col := MJFAMIXColumn new
					name: #Column2..
					
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	
	stream := ReadWriteStream on: ''.
	col printOn: stream.
	
	self assert: (stream contents = (col name asString , ' (Column)')).

]

{ #category : #'as yet unclassified' }
MJFAMIXColumnTests >> testPrintOnWithTable [
	| col stream tab |
	
	col := MJFAMIXColumn new
					name: #Column2.
					
	tab := MJFAMIXTable new name: 'Table1'.
	
	col ownerTable: tab.
					
	self assert: (col isMemberOf: MJFAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col ownerTable = tab).

	stream := ReadWriteStream on: ''.
	col printOn: stream.
	
	self assert: (stream contents = (col ownerTable name asString , '>>>' , col name asString , ' (Column)')).

]
