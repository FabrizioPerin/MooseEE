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
	self privateState attributeAt: #implementedRole put: [
		FMMultivalueLink 
		on: self
		update: #Implementor
		from: self implementedRole
		to: aMJDPRoleAssociation].
]
