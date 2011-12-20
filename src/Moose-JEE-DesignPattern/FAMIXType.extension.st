Extension { #name : #FAMIXType }

{ #category : #'*moose-jee-designpattern' }
FAMIXType >> implementedRole [
	<MSEProperty: #implementedRole type: #MJDPRoleAssociation opposite: #implementor>
	<MSEComment: 'Association with the role implemented by this class'>
	
	^self privateState attributeAt: #implementedRole ifAbsentPut: [FMMultivalueLink 
		on: self
		opposite: #implementor:.]. 
]

{ #category : #'*moose-jee-designpattern' }
FAMIXType >> implementedRole: aMJDPRoleAssociation [
	"This method contains a work around to make possible a 1to 1 relation with the MJDPRoleAssociation instance"
	self privateState attributeAt: #implementedRole put: (self implementedRole value: (OrderedCollection with: aMJDPRoleAssociation)).
]
