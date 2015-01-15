Class {
	#name : #MobiApplicationsImporter,
	#superclass : #Object,
	#instVars : [
		'applications',
		'model'
	],
	#category : #'Mobi-MooseEE-Architecture-Model'
}

{ #category : #'as yet unclassified' }
MobiApplicationsImporter class >> on: aMooseModel [ 
	^ self new model: aMooseModel
]

{ #category : #'as yet unclassified' }
MobiApplicationsImporter >> createApplications [

	applications := Dictionary new.
	
	BusinessApplications class methods do: [ :compileMethod |
		| newAppl |
		
		newAppl := MobiApplication new name: compileMethod selector.
		newAppl isBusiness: true.
		
		self reifyApplicationContentFor: newAppl From: (BusinessApplications perform: compileMethod selector).
		
		applications 
			at: compileMethod selector 
			put: newAppl].
	
	InfrastructureApplications class methods do: [ :compileMethod |
		| newAppl |
		
		newAppl := MobiApplication new name: compileMethod selector.
		newAppl isBusiness: false.
		
		self reifyApplicationContentFor: newAppl From: (InfrastructureApplications perform: compileMethod selector).
		
		applications 
			at: compileMethod selector 
			put: newAppl].
	
]

{ #category : #accessing }
MobiApplicationsImporter >> model [
	^ model
]

{ #category : #accessing }
MobiApplicationsImporter >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
MobiApplicationsImporter >> populateModelWithApplications [

	self createApplications.
	self propagateMissingApplicationFromTables.
	self reifyCobolHierarchy.
	
	applications valuesDo: [ :application |
		model silentlyAdd: application.
		model silentlyAddAll: application containedElements ]
]

{ #category : #'as yet unclassified' }
MobiApplicationsImporter >> propagateMissingApplicationFromTables [

	model allTables 
		do: [ :table |
			table views 
				do: [:viewAssoc |
					viewAssoc from containerComponents isEmpty
						ifTrue: [ 
							(table containerComponents collect: #from)
								do: [ :each | 
									| containment |
									containment := MEEContainment new.
									containment containerComponent: each.
									containment containedElement: viewAssoc from ] ] ] ]
]

{ #category : #'as yet unclassified' }
MobiApplicationsImporter >> reifyApplicationContentFor: anApplication From: aCollectionOfTableAndViewNames [

	aCollectionOfTableAndViewNames do: [ :tableName |
			| initialElements |
			initialElements := ( ( model  allWithType: FAMIXView) select: [ :each | each completeName = tableName ] ).
			initialElements addAll: ( ( initialElements flatCollect: [ :view | view ofTables ] ) collect: #table ).
			initialElements addAll: ( ( model  allWithType: FAMIXTable) select: [ :each | each completeName = tableName ] ).
			
			initialElements asSet do: [ :el |
				| containment |
				containment := MEEContainment new.
				containment containerComponent: anApplication.
				containment containedElement: el ] ].
]

{ #category : #'as yet unclassified' }
MobiApplicationsImporter >> reifyCobolHierarchy [

	applications valuesDo: [ :application |
		application containedElements do: [ :containment |
			| initialCobolElements cobolElementsToAdd |

			cobolElementsToAdd := Set new.
			(containment containedElement isKindOf: FAMIXTable) ifTrue: [ 
				initialCobolElements := ( ( containment containedElement sourceAccessors collect: #from ) asSet select: [ :each | each isMemberOf: FAMIXCobolList ] ).
				initialCobolElements do: [ :cobolList | cobolElementsToAdd addAll: cobolList withDeepCallingCobolLists ].

				cobolElementsToAdd := cobolElementsToAdd reject: [ :each | application containedElements anySatisfy: [ :el | el to = each ] ].
				
				cobolElementsToAdd do: [ :el |
					| newContainment |
					newContainment := MEEContainment new.
					newContainment containerComponent: application.
					newContainment containedElement: el ] ] ] ]
]
