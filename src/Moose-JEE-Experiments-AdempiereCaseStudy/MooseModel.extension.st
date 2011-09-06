Extension { #name : #MooseModel }

{ #category : #'*Moose-JEE-Experiments-AdempiereCaseStudy' }
MooseModel >> browseMappings [
	<menuItem: 'Rima Browser for mappings' category: 'JEAs Browsers'>
	MJRimaMappingBrowser new browser openOn: self	
]
