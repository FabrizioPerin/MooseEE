Extension { #name : #FAMIXTableGroupTests }

{ #category : #'*moose-jee-tests-sql' }
FAMIXTableGroupTests >> testComputeDeriveDependenciesFromSourceCode [

	| jEETestModel mooseModel root annotationType famixAnchor distances result mapping table class |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithTransAndInvocationsAndDBAndQueryComplex.

	"adding fake mappings"
	table := (mooseModel allTables select: [:each | each name = #Table1]) first.
	class := (mooseModel allClasses select: [:each | each name = #AStatelessSessionBean]) first.
	mapping := FAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel silentlyAdd: mapping.
	
	table := (mooseModel allTables select: [:each | each name = #Table2]) first.
	class := (mooseModel allClasses select: [:each | each name = #Class4]) first.
	mapping := FAMIXMapping new mapTarget: table ; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel silentlyAdd: mapping.
						
	self assert: (mooseModel allMaps size = 2).
	
	mooseModel allTables computeDeriveDependenciesFromSourceCode.
	
	self assert: (mooseModel allDerivedDependencies size = 1).
	self assert: mooseModel allDerivedDependencies first isDirected not.   
	self assert: (mooseModel allDerivedDependencies first source = (mooseModel allTables select: [:each | each name = #Table1]) first).
	self assert: (mooseModel allDerivedDependencies first target = (mooseModel allTables select: [:each | each name = #Table2]) first).
	
	
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXTableGroupTests >> testComputeDeriveDependenciesFromSourceCodeNoDependencies [

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
	
	(MJMappingStrategy on: mooseModel) buildRelationsAmongDBTablesAndClasses.
	
	self assert: (mooseModel allMaps size = 2).
	
	
	mooseModel allTables computeDeriveDependenciesFromSourceCode.
	
	self assert: (mooseModel allDerivedDependencies size = 0).
	
	
]

{ #category : #'*moose-jee-tests-sql' }
FAMIXTableGroupTests >> testLevenshteinDistancesAmongFieldsTable [
	| mooseModel distances transposed |
	mooseModel := FAMIXSQLTestResources new sampleMooseModelContainingJustADB.
	self assert: mooseModel allTables size = 3.
	self assert: mooseModel allFKAssociations size = 2.
	self assert: mooseModel allColumns size = 75.
	distances := mooseModel allTables levenshteinDistancesAmongFieldsTable.
	self assert: distances size = 6.
	self assert: (distances allSatisfy: [ :each | each isMemberOf: MalWeightedEdge ]).
	self assert: (distances allSatisfy: [ :each | each from isMemberOf: FAMIXColumn ]).
	self assert: (distances allSatisfy: [ :each | each to isMemberOf: FAMIXColumn ]).	
	
	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Client_ID'
						and: [ each from ownerTable name = 'AD_User'
							and: [ each to name = 'AD_Client_ID' 
								and: [ each to ownerTable name = 'A_Asset_Group' 
									and: [ each weight = 0 ] ] ] ] ]) size				
		equals: 1.

	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Org_ID'
						and: [ each from ownerTable name = 'A_Asset'
							and: [ each to name = 'AD_Org_ID' 
								and: [ each to ownerTable name = 'A_Asset_Group' 
									and: [ each weight = 0 ] ] ] ] ]) size				
		equals: 1.

	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Org_ID'
						and: [ each from ownerTable name = 'AD_User'
							and: [ each to name = 'AD_OrgTrx_ID' 
								and: [ each to ownerTable name = 'AD_User' 
									and: [ each weight = 3 ] ] ] ] ]) size				
		equals: 1.

	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Client_ID'
						and: [ each from ownerTable name = 'A_Asset'
							and: [ each to name = 'AD_Client_ID' 
								and: [ each to ownerTable name = 'A_Asset_Group' 
									and: [ each weight = 0 ] ] ] ] ]) size				
		equals: 1.

	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Org_ID'
						and: [ each from ownerTable name = 'A_Asset'
							and: [ each to name = 'AD_OrgTrx_ID' 
								and: [ each to ownerTable name = 'AD_User' 
									and: [ each weight = 3 ] ] ] ] ]) size				
		equals: 1.

	self
		assert:
			(distances
				select: [ :each | 
					each from name = 'AD_Org_ID'
						and: [ each from ownerTable name = 'AD_User'
							and: [ each to name = 'AD_Org_ID' 
								and: [ each to ownerTable name = 'A_Asset_Group' 
									and: [ each weight = 0 ] ] ] ] ]) size				
		equals: 1.
]
