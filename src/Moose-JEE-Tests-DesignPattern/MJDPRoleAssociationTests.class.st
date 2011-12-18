Class {
	#name : #MJDPRoleAssociationTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'fame annotation' }
MJDPRoleAssociationTests class >> annotation [
	<MSEClass: #MJDPRoleAssociation super: #FAMIXAssociation>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (DPRoleAssociation)'
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testAnnotation [
	self assert: MJDPRoleAssociation annotation == MJDPRoleAssociation.
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testFrom [
	| assoc role |

	assoc := MJDPRoleAssociation new.
	role := MJDPRole new.

	self assert: (assoc isMemberOf: MJDPRoleAssociation).

	assoc role: role.

	self assert: assoc from equals: role.
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testImplementor [
	| assoc class |

	assoc := MJDPRoleAssociation new.
	class := FAMIXType new.

	self assert: (assoc isMemberOf: MJDPRoleAssociation).

	assoc implementor: class.

	self assert: assoc implementor equals: class.
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testMJDPRoleAssociationCreation [
	| assoc |

	assoc := MJDPRoleAssociation new.
	
	self assert: (assoc isMemberOf: MJDPRoleAssociation).
	self assert: assoc from isNil.
	self assert: assoc to isNil.
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testRole [
	| assoc role |

	assoc := MJDPRoleAssociation new.
	role := MJDPRole new.

	self assert: (assoc isMemberOf: MJDPRoleAssociation).

	assoc role: role.

	self assert: assoc role equals: role.
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> testTo [
	| assoc class |

	assoc := MJDPRoleAssociation new.
	class := FAMIXType new.

	self assert: (assoc isMemberOf: MJDPRoleAssociation).

	assoc implementor: class.

	self assert: assoc to equals: class.
]
