Class {
	#name : #InfrastructureApplications,
	#superclass : #ApplicationDefinition,
	#category : #'Mobi-MooseEE-Architecture-Model'
}

{ #category : #'as yet unclassified' }
InfrastructureApplications class >> isdv [
	^#(
	'DB2YVIEW.VISCART1'
	'DB2YVIEW.VISVCOA1'
	'DB2YVIEW.VINFCOD1'
	'DB2YVIEW.VPE07521_A'
	'DB2YVIEW.VPE07521'
	'DB2YVIEW.VINFCOD1_A'
	)
]

{ #category : #'as yet unclassified' }
InfrastructureApplications class >> texte [
	^#(
	'DB2YVIEW.VP2TEXT1'
	'DB2YVIEW.VINFCOD1'
	)
]

{ #category : #'as yet unclassified' }
InfrastructureApplications >> seeClassSide [
]
