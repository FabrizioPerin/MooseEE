Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Reports' }
MooseModel >> mappingAmongScriptsAndTableReport [
	<menuItem: 'Mapping Group Report' category: 'JEAs Reports'>

	|spec|
	spec := REPConcernSpecification on: self.
	spec label: 'Mapping Group Report'.

	spec composite: 'Potential matches through tables' with: [
 		 spec concern: MJFAMIXScriptGroupReports new ].
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
