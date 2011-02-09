Class {
	#name : #MJFAMIXTableGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testComputeDeriveDependenciesFromSourceCode [

	| jEETestModel mooseModel root annotationType famixAnchor distances result mapping table class |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithTransAndInvocationsAndDBAndQueryComplex.
	mooseModel ejbVersion: #EJB30.

	"adding fake mappings"
	table := (mooseModel allTables select: [:each | each name = #Table1]) first.
	class := (mooseModel allClasses select: [:each | each name = #AStatelessSessionBean]) first.
	mapping := MJFAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel withoutAnnounceAdd: mapping.
	
	table := (mooseModel allTables select: [:each | each name = #Table2]) first.
	class := (mooseModel allClasses select: [:each | each name = #Class4]) first.
	mapping := MJFAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel withoutAnnounceAdd: mapping.
						
	self assert: (mooseModel allMaps size = 2).
	
	mooseModel allTables computeDeriveDependenciesFromSourceCode.
	
	self assert: (mooseModel allDerivedDependencies size = 1).
	self assert: mooseModel allDerivedDependencies first isDirected not.   
	self assert: (mooseModel allDerivedDependencies first source = (mooseModel allTables select: [:each | each name = #Table1]) first).
	self assert: (mooseModel allDerivedDependencies first target = (mooseModel allTables select: [:each | each name = #Table2]) first).
	
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testComputeDeriveDependenciesFromSourceCodeNoDependencies [

	| jEETestModel mooseModel root annotationType famixAnchor distances result |

	jEETestModel := JEETestModels new.
	mooseModel := jEETestModel sampleMooseModelWithTransAndInvocationsAndDBAndQueryComplex.
	mooseModel ejbVersion: #EJB30.

	root := jEETestModel root.

	"define Entity beans"
	(root allElements select: [:each | each class = MJEntityElement]) do: [:each | each populate: mooseModel].
	
	self assert: (mooseModel allEntityBeans size = 2).
	self assert: (mooseModel allTables size = 3).
	
	"Creating the annotation type Table"
	annotationType := FAMIXAnnotationType new name: #Table.
	mooseModel add: annotationType.
	
	"Creating the instances"
	mooseModel allEntityBeans do: [:bean | 
							| instance |
							instance := FAMIXAnnotationInstance new.
							instance annotationType: annotationType.
							instance annotatedEntity: bean.
							mooseModel add: instance].
						
	"adding a fake sourceText to one Entity"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceText.
	(mooseModel allEntityBeans select: [:each | each name = #ACMPEntity]) first sourceAnchor: famixAnchor.

	"adding a fake sourceText to another Entity"
	famixAnchor := FAMIXSourceTextAnchor new source: jEETestModel fakeSourceTextWithTable2.
	(mooseModel allEntityBeans select:[:each | each name = #ABMPEntity]) first sourceAnchor: famixAnchor.
	
	mooseModel buildRelationsAmongDBTablesAndClasses.
	
	self assert: (mooseModel allMaps size = 2).
	
	
	mooseModel allTables computeDeriveDependenciesFromSourceCode.
	
	self assert: (mooseModel allDerivedDependencies size = 0).
	
	
]

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testLevenshteinDistancesAmongFieldsTable [

	| mooseModel distances transposed |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allFKAssociations size = 2).
	self assert: (mooseModel allColumns size = 75).

	distances := mooseModel allTables levenshteinDistancesAmongFieldsTable.
	
	self assert: (distances size = 5).
	self assert: (distances allSatisfy: [:each | each isMemberOf: MalWeightedEdge]).
	
	self assert: (distances first from isMemberOf: MJFAMIXColumn).
	self assert: (distances first from name = 'AD_Client_ID'). 
	self assert: (distances first from ownerTable name = 'A_Asset'). 
	self assert: (distances first to isMemberOf: MJFAMIXColumn).
	self assert: (distances first to name = 'AD_Client_ID'). 
	self assert: (distances first to ownerTable name = 'A_Asset_Group').
	self assert: (distances first weight = 0).
	
	self assert: (distances second from isMemberOf: MJFAMIXColumn).
	self assert: (distances second from name = 'AD_Org_ID'). 
	self assert: (distances second from ownerTable name = 'A_Asset'). 
	self assert: (distances second to isMemberOf: MJFAMIXColumn).
	self assert: (distances second to name = 'AD_Org_ID'). 
	self assert: (distances second to ownerTable name = 'A_Asset_Group').
	self assert: (distances second weight = 0). 
	
	self assert: (distances third from isMemberOf: MJFAMIXColumn).
	self assert: (distances third from name = 'AD_Client_ID'). 
	self assert: (distances third from ownerTable name = 'A_Asset'). 
	self assert: (distances third to isMemberOf: MJFAMIXColumn).
	self assert: (distances third to name = 'AD_Client_ID'). 
	self assert: (distances third to ownerTable name = 'AD_User').
	self assert: (distances third weight = 0). 
	
	self assert: ((distances at: 4) from isMemberOf: MJFAMIXColumn).
	self assert: ((distances at: 4) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 4) to isMemberOf: MJFAMIXColumn).
	self assert: ((distances at: 4) to name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) to ownerTable name = 'AD_User').
	self assert: ((distances at: 4) weight = 0). 
	
	self assert: ((distances at: 5) from isMemberOf: MJFAMIXColumn).
	self assert: ((distances at: 5) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 5) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 5) to isMemberOf: MJFAMIXColumn).
	self assert: ((distances at: 5) to name = 'AD_OrgTrx_ID'). 
	self assert: ((distances at: 5) to ownerTable name = 'AD_User').
	self assert: ((distances at: 5) weight = 3). 
]
