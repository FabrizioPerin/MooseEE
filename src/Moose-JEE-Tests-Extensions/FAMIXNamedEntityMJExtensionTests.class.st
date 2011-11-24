Class {
	#name : #FAMIXNamedEntityMJExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-Extensions'
}

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testDerivedDependenciesDirectionOn [

	| invokedEntity invokingEntity derivedDependecy mooseModel derivedConnections |
	
	mooseModel := JEETestModels new sampleMooseModel.
	
	invokedEntity := FAMIXNamedEntity new name: 'testEntityInvoked'. 
	invokingEntity := FAMIXNamedEntity new name: 'testEntityInvoking'.
	
	derivedDependecy := MJFAMIXDerivedDependency new source: invokingEntity; target: invokedEntity.

	invokingEntity addOutgoingDerivedDependency: derivedDependecy.
	invokedEntity addIncomingDerivedDependency: derivedDependecy.
	
	mooseModel add: invokingEntity.
	mooseModel add: invokedEntity.
	mooseModel add: derivedDependecy.
	
	self assert: (mooseModel allDerivedDependencies size = 1).
	
	self assert: ((invokingEntity derivedDependenciesDirection: #target on: mooseModel allDerivedDependencies) first = invokedEntity).
	self assert: ((invokingEntity derivedDependenciesDirection: #source on: mooseModel allDerivedDependencies) isEmpty).
	
	self assert: ((invokedEntity derivedDependenciesDirection: #source on: invokedEntity mooseModel allDerivedDependencies) first = invokingEntity).
	self assert: ((invokedEntity derivedDependenciesDirection: #target on: invokedEntity mooseModel allDerivedDependencies) isEmpty).
]

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testIncomingDerivedDependency [

	| namedEntity derivedDependecy |
	
	namedEntity := FAMIXNamedEntity new name: 'testEntity'. 
	
	derivedDependecy := MJFAMIXDerivedDependency new target: namedEntity.

	namedEntity addIncomingDerivedDependency: derivedDependecy.
	
	self assert: (namedEntity isMemberOf: FAMIXNamedEntity).

	self assert: (namedEntity incomingDerivedDependency isMemberOf: FMMultivalueLink).
	self assert: (namedEntity incomingDerivedDependency size = 1).
	self assert: (namedEntity incomingDerivedDependency first = derivedDependecy).
	self assert: (namedEntity incomingDerivedDependency first to = namedEntity).

]

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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (aCMPEntity mappedRelationalEntities size = 1).
	self assert: (aCMPEntity mappedRelationalEntities first = table1 ).
	
	

]

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testOutgoingAndIncomingDerivedDependency [

	| invokedEntity invokingEntity derivedDependecy |
	
	invokedEntity := FAMIXNamedEntity new name: 'testEntityInvoked'. 
	invokingEntity := FAMIXNamedEntity new name: 'testEntityInvoking'.
	
	derivedDependecy := MJFAMIXDerivedDependency new source: invokingEntity; target: invokedEntity.

	invokingEntity addOutgoingDerivedDependency: derivedDependecy.
	invokedEntity addIncomingDerivedDependency: derivedDependecy.
	
	self assert: (invokedEntity isMemberOf: FAMIXNamedEntity).
	self assert: (invokedEntity incomingDerivedDependency isMemberOf: FMMultivalueLink).
	self assert: (invokedEntity incomingDerivedDependency size = 1).
	self assert: (invokedEntity incomingDerivedDependency first = derivedDependecy).
	self assert: (invokedEntity incomingDerivedDependency first to = invokedEntity).

	self assert: (invokingEntity isMemberOf: FAMIXNamedEntity).
	self assert: (invokingEntity outgoingDerivedDependency isMemberOf: FMMultivalueLink).
	self assert: (invokingEntity outgoingDerivedDependency size = 1).
	self assert: (invokingEntity outgoingDerivedDependency first = derivedDependecy).
	self assert: (invokingEntity outgoingDerivedDependency first from = invokingEntity).

]

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testOutgoingDerivedDependency [

	| namedEntity derivedDependecy |
	
	namedEntity := FAMIXNamedEntity new name: 'testEntity'. 
	
	derivedDependecy := MJFAMIXDerivedDependency new source: namedEntity.

	namedEntity addOutgoingDerivedDependency: derivedDependecy.
	
	self assert: (namedEntity isMemberOf: FAMIXNamedEntity).

	self assert: (namedEntity outgoingDerivedDependency isMemberOf: FMMultivalueLink).
	self assert: (namedEntity outgoingDerivedDependency size = 1).
	self assert: (namedEntity outgoingDerivedDependency first = derivedDependecy).
	self assert: (namedEntity outgoingDerivedDependency first from = namedEntity).

]

{ #category : #tests }
FAMIXNamedEntityMJExtensionTests >> testRemovePointersToMaps [
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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	aCMPEntity := (mooseModel allEntityBeans select: [:bean | bean name = #ACMPEntity]) first. 
	table1 := (mooseModel allTables select: [:table | table name = 'Table1']) first .

	self assert: (aCMPEntity mappedRelationalEntities size = 1).
	self assert: (aCMPEntity mappedRelationalEntities first = table1 ).
	
	mooseModel silentlyRemoveAll: (mooseModel allWithType: MJFAMIXMapping).
	
	aCMPEntity implementationClass removePointersToMaps.
	
	self assert: (aCMPEntity mappedRelationalEntities size = 0).
	
	
	

]
