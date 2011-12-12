Class {
	#name : #MapColumnsOnMethodsAndAttributesTests,
	#superclass : #TestCase,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-Tests-Importers-SQL'
}

{ #category : #'as yet unclassified' }
MapColumnsOnMethodsAndAttributesTests >> testBuildMapsOn [
	| mooseModel annotationType jEETestModel table1 annotationTypeColumn famixAnchor maps classesWithAnnotations |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	mooseModel ejbVersion: #EJB30.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	"Creating the annotation type Table"
	annotationType := FAMIXAnnotationType new name: #Table.
	mooseModel add: annotationType.
	
	annotationTypeColumn := FAMIXAnnotationType new name: #Column.
	mooseModel add: annotationTypeColumn.
	
	"Creating the Table instances"
	classesWithAnnotations := mooseModel allClasses select: [:each | (each name = #ACMPEntityBean) or:[each name = #ABMPEntityBean]].
	classesWithAnnotations do: [:bean | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationType.
							instance annotatedEntity: bean.
							mooseModel add: instance.
							 ].
				
	"Creating the Columns instances"
	classesWithAnnotations do: [:class |
		class attributes do: [:attr |
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationTypeColumn.
							instance annotatedEntity: attr.
							mooseModel add: instance]].
						
	"adding a fake sourceText to the Entities"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	classesWithAnnotations do: [:bean | 
			bean sourceAnchor: famixAnchor.].
	
	mooseModel allAttributes do: [:attr |
		attr name = 'Att1' ifTrue: [attr declaredType: (FAMIXClass new	name: 'WorkUnitAuthOperation'; yourself)].
		attr name = 'Att2' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].
		attr name = 'Att3' ifTrue: [attr declaredType: (FAMIXClass new	name: 'String'; yourself)].].
	
	MapTablesOnClassesUsingAnnotations new buildMapsOn: mooseModel.
	MapColumnsOnMethodsAndAttributes new buildMapsOn: mooseModel.

	self assert: (mooseModel allColumns size = 6).

	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: FAMIXColumn]).

	self assert: (maps size = 3).
		
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column2]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column4]).
	self assert: (maps anySatisfy: [:map | map mapTarget name = #Column6]).

]
