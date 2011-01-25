Extension { #name : #MooseModel }

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
