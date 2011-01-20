Class {
	#name : #MJFAMIXTableGroupTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXTableGroupTests >> testLevenshteinDistancesAmongFieldsTable [

	| mooseModel distances transposed |
	
	
	mooseModel := JEETestModels new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allFKAssociations size = 2).
	self assert: (mooseModel allColumns size = 75).

	distances := mooseModel allTables levenshteinDistancesAmongFieldsTable.
	
	self assert: (distances size = 5).
	self assert: (distances allSatisfy: [:each | each isKindOf: MalWeightedEdge]).
	
	self assert: (distances first from isKindOf: MJFAMIXColumn).
	self assert: (distances first from name = 'AD_Client_ID'). 
	self assert: (distances first from ownerTable name = 'A_Asset'). 
	self assert: (distances first to isKindOf: MJFAMIXColumn).
	self assert: (distances first to name = 'AD_Client_ID'). 
	self assert: (distances first to ownerTable name = 'A_Asset_Group').
	self assert: (distances first weight = 0).
	
	self assert: (distances second from isKindOf: MJFAMIXColumn).
	self assert: (distances second from name = 'AD_Org_ID'). 
	self assert: (distances second from ownerTable name = 'A_Asset'). 
	self assert: (distances second to isKindOf: MJFAMIXColumn).
	self assert: (distances second to name = 'AD_Org_ID'). 
	self assert: (distances second to ownerTable name = 'A_Asset_Group').
	self assert: (distances second weight = 0). 
	
	self assert: (distances third from isKindOf: MJFAMIXColumn).
	self assert: (distances third from name = 'AD_Client_ID'). 
	self assert: (distances third from ownerTable name = 'A_Asset'). 
	self assert: (distances third to isKindOf: MJFAMIXColumn).
	self assert: (distances third to name = 'AD_Client_ID'). 
	self assert: (distances third to ownerTable name = 'AD_User').
	self assert: (distances third weight = 0). 
	
	self assert: ((distances at: 4) from isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 4) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 4) to isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 4) to name = 'AD_Org_ID'). 
	self assert: ((distances at: 4) to ownerTable name = 'AD_User').
	self assert: ((distances at: 4) weight = 0). 
	
	self assert: ((distances at: 5) from isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 5) from name = 'AD_Org_ID'). 
	self assert: ((distances at: 5) from ownerTable name = 'A_Asset'). 
	self assert: ((distances at: 5) to isKindOf: MJFAMIXColumn).
	self assert: ((distances at: 5) to name = 'AD_OrgTrx_ID'). 
	self assert: ((distances at: 5) to ownerTable name = 'AD_User').
	self assert: ((distances at: 5) weight = 3). 
]
