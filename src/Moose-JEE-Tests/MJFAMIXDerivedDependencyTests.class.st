Class {
	#name : #MJFAMIXDerivedDependencyTests,
	#superclass : #MJAssociationTests,
	#category : #'Moose-JEE-Tests'
}

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependencyTests >> testDerivedDependencyCreation [
	| dep tab1 tab2 |
	
	dep := MJFAMIXDerivedDependency new.
	
	self assert: (dep isMemberOf: MJFAMIXDerivedDependency).
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependencyTests >> testDerivedDependencyCreationIsDerived [
	| dep tab1 tab2 |
	
	dep := MJFAMIXDerivedDependency new isDirected: false.
	
	self assert: (dep isMemberOf: MJFAMIXDerivedDependency).
	self deny: dep isDirected.
	
	dep isDirected: true.
	
	self assert: dep isDirected.  
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependencyTests >> testDerivedDependencyCreationSourceAndTarget [
	| dep tab1 tab2 |
	
	dep := MJFAMIXDerivedDependency new isDirected: false.
	
	self assert: (dep isMemberOf: MJFAMIXDerivedDependency).
	
	tab1 := (MJFAMIXTable new name: #Table1).
	tab2 := (MJFAMIXTable new name: #Table2).
	
	dep source: tab1.
	dep target: tab2.
		
	self assert: (dep target = tab2). 
	self assert: (dep source = tab1).
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependencyTests >> testDerivedDependencyRational [
	| dep tab1 tab2 |
	
	dep := MJFAMIXDerivedDependency new.
	
	self assert: (dep isMemberOf: MJFAMIXDerivedDependency).
	
	dep rationale: 'Connection derived from connections among source code elements.'.
				
	self assert: (dep rationale = 'Connection derived from connections among source code elements.').
]
