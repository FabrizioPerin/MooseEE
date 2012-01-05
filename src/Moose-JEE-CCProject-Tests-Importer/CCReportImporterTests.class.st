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
CCReportImporterTests >> testImportFullReportWithoutCode [
	| mm |
	
	self assert: (importer parser isMemberOf: XMLDOMParser).
	self assert: importer parser document equals: nil.
	
	mm := MooseModel new.
	self assert: importer targetModel equals: nil.
	
	importer targetModel: mm.
	
	importer importFrom: MJCCPSampleReports fullReportWithoutCode readStream.
	
	self assert: (importer parser document isMemberOf: XMLDocument).
	self assert: importer targetModel equals: mm.
	self assert: (mm allWithType: MJCCPClones) size equals: 1.
	self assert: (mm allWithType: MJCCPSysteminfo) size equals: 1.
	self assert: (mm allWithType: MJCCPClassinfo) size equals: 1.
]

{ #category : #'as yet unclassified' }
CCReportImporterTests >> testImportSmallReport [
	| mm |
	
	self assert: (importer parser isMemberOf: XMLDOMParser).
	self assert: importer parser document equals: nil.
	
	mm := MooseModel new.
	self assert: importer targetModel equals: nil.
	
	importer targetModel: mm.
	
	importer importFrom: MJCCPSampleReports smallReport readStream.
	
	self assert: (importer parser document isMemberOf: XMLDocument).
	self assert: importer targetModel equals: mm.
	self assert: (mm allWithType: MJCCPClones) size equals: 1.
	self assert: (mm allWithType: MJCCPSysteminfo) size equals: 1.
	self assert: (mm allWithType: MJCCPClassinfo) size equals: 1.
	
	self assert: (mm allWithType: MJCCPClass) size equals: 5.
	self assert: (mm allWithType: MJCCPSource) size equals: 11.
	
	
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
CCReportImporterTests >> testTargetModel [
	| mm |
	
	mm := MooseModel new.
	self assert: importer targetModel equals: nil.
	
	importer targetModel: mm.
	
	self assert: (importer targetModel isMemberOf: MooseModel).
	self assert: importer targetModel equals: mm
	.
	

]
