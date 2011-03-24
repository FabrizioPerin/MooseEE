Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> derivedDependenciesReport [
	<menuItem: 'Derived Dependencies' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Derived dependencies Report'.

	spec composite: 'Browser for derived dependencies' with: [
 		 spec concern: MJFAMIXDerivedDependenciesReport new ].
	spec open
]

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> fkImprvedIdentificationReport [
	<menuItem: 'Improved identification' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Mapping Group Report'.

	spec composite: 'Potential matches through tables' with: [
 		 spec concern: MJFAMIXFKIdentificationReport new ].
	spec open
]

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> levensteinDistranceReport [
	<menuItem: 'Levenstein distrance report' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Table Group Report'.

	spec composite: 'Levenstein distrance report' with: [
 		 spec concern: MJFAMIXFKIdentificationReport new ].
	spec open
]

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> mappingAmongScriptsAndTableReport2 [
	<menuItem: 'Mapping Group Report 2' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Mapping Group Report'.

	spec composite: 'Potential matches through tables' with: [
 		 spec concern: MJFAMIXFKGroupingByScriptRelationsReport new ].
	spec open
]

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> tableGroupReport [
	<menuItem: 'Table Group Report' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Table Group Report'.

	spec composite: 'FK potential matches' with: [
 		 spec concern: MJFAMIXTableGroupReports new ].
	spec open
]
