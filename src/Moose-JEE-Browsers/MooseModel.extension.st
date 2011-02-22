Extension { #name : #MooseModel }

{ #category : #'*moose-jee-browsers' }
MooseModel >> browseForeignKeys [
	<menuItem: 'Browser for foreign keys' category: 'JEAs Browsers'>
	MJFKsBrowser new browser openOn: self	
]
