Class {
	#name : #DependencyAnalysisTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Experiments-AdempiereCaseStudy'
}

{ #category : #'as yet unclassified' }
DependencyAnalysisTests >> testCreation [

	| dependencyAnalysis |
	
	dependencyAnalysis := DependencyAnalysis new.
	
	self assert: (dependencyAnalysis isMemberOf: DependencyAnalysis).
]

{ #category : #'as yet unclassified' }
DependencyAnalysisTests >> testCreationOn [

	| dependencyAnalysis |
	
	dependencyAnalysis := DependencyAnalysis on: MooseModel new.
	
	self assert: (dependencyAnalysis isMemberOf: DependencyAnalysis).
	self assert: (dependencyAnalysis targetModel isMemberOf: MooseModel).
]

{ #category : #'as yet unclassified' }
DependencyAnalysisTests >> testTargetModel [

	| dependencyAnalysis |
	
	dependencyAnalysis := DependencyAnalysis new.
	
	self assert: (dependencyAnalysis isMemberOf: DependencyAnalysis).
	self assert: dependencyAnalysis targetModel isNil.
	
	dependencyAnalysis targetModel: MooseModel new.
	
	self assert: (dependencyAnalysis targetModel isMemberOf: MooseModel).
	
]
