Class {
	#name : #MJFAMIXTableTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testAddColumn [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	
	table3 addColumn: (MJFAMIXColumn new name: #Column2).
					
	self assert: (table3 columns size = 9).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	

]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testConstraints [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 constraints size = 2).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testCreation [
	| tab |

	tab := MJFAMIXTable new name: 'Table1'.
	
	self assert: (tab isMemberOf: MJFAMIXTable).     
	self assert: (tab name = 'Table1').  
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testInUse [
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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.

	self assert: (mooseModel allColumns size = 6).
	
	maps := (mooseModel allMaps select: [:each | each mapTarget isKindOf: MJFAMIXTable]).

	self assert: (maps size = 1).

	self assert: (maps anySatisfy: [:map | map mapTarget name = #Table1 and: [map mapTarget inUse]]).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameAsRegex [
	| table |

	table := MJFAMIXTable new name: #col1.
	
	self assert: (table nameAsRegex isMemberOf: RxMatcher).
	self assert: (table nameAsRegex matches: #col1).
	self assert: (table nameAsRegex matches: 'asfdcol1asdf').
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testNameAsRegexIgnoringCase [
	
	| col |
	col := MJFAMIXTable new name: #col1.
	
	self assert: (col nameAsRegexIgnoringCase isMemberOf: RxMatcher).
	self assert: (col nameAsRegexIgnoringCase matches: #col1).
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdcol1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdCOL1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: #COL1).
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
MJFAMIXTableTests >> testSetColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	self assert: (table3 columns size = 8).
	
	table3 columns: (Array with: (MJFAMIXColumn new name: #Column2) with: (MJFAMIXColumn new name: #Column1)) .
					
	self assert: (table3 columns size = 2).
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencedByTables [	
	| jEETestModel mooseModel table3 tablesReferenceingTable3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	
	tablesReferenceingTable3 := table3 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 3).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencedByTablesOnTwoLevels [	
	| jEETestModel mooseModel table1 tablesReferenceingTable3 |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: MJFAMIXTable).
	
	tablesReferenceingTable3 := table1 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 4).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTables [	
	| jEETestModel mooseModel table3 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: MJFAMIXTable).
	
	referencedTables := table3 withDeepReferencesTables.
	
	self assert: (referencedTables size = 3).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferencedTables [
	| jEETestModel mooseModel table1 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: MJFAMIXTable).
	
	referencedTables := table1 withDeepReferencesTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table1).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferenceingTables [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: MJFAMIXTable).
	
	referencedTables := table5 withDeepReferencedByTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table5).
	    
]

{ #category : #'as yet unclassified' }
MJFAMIXTableTests >> testWithDeepReferencesTablesOnTwoLevels [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.
	mooseModel ejbVersion: #EJB30.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: MJFAMIXTable).
	
	referencedTables := table5 withDeepReferencesTables.
	
	self assert: (referencedTables size = 4).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]
