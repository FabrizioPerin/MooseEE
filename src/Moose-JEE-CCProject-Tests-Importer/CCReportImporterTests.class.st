Class {
	#name : #CCReportImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'importer'
	],
	#category : #'Moose-JEE-CCProject-Tests-Importer'
}

{ #category : #'as yet unclassified' }
CCReportImporterTests >> setUp [

	importer := MJCCReportImporter new.

]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testImportFrom [
	| result mm |
	
	mm := MooseModel new.
	importer := MJCCReportImporter new targetModel: mm.
	
	result := importer importFrom: MJCCPSampleReports fullReportWithoutCode readStream.
	
	self assert: (result isMemberOf: MooseModel).
]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testImporterCreation [

	self assert: (importer isMemberOf: MJCCReportImporter). 
	self assert: (importer parser isMemberOf: XMLDOMParser).
	self assert: importer parser document equals: nil.
	
]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testImporterCreationOn [

	importer := MJCCReportImporter on: MooseModel new.

	self assert: (importer isMemberOf: MJCCReportImporter). 
	self assert: (importer parser isMemberOf: XMLDOMParser).
	self assert: importer parser document equals: nil.
	
]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testParse [
	
	self assert: (importer parser isMemberOf: XMLDOMParser).
	self assert: importer parser document equals: nil.
	
	importer importFrom: MJCCPSampleReports fullReportWithoutCode readStream.
	
	self assert: (importer parser document isMemberOf: XMLDocument).
]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testTargetModel [
	| mm |
	
	mm := MooseModel new.
	self assert: importer targetModel equals: nil.
	
	importer targetModel: mm.
	
	self assert: (importer targetModel isMemberOf: MooseModel).
	self assert: importer targetModel equals: mm
	.
	

]
