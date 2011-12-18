Class {
	#name : #MJDPRoleTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPRoleTests class >> annotation [
	<MSEClass: #MJDPRole super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> testAnnotation [
	self assert: MJDPRole annotation == MJDPRole.
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> testAssociatedClass [
	| role classRoleAssoc |
	
	role := MJDPRole new.
	classRoleAssoc := MJDPRoleAssociation new.
	
	self assert: (role isMemberOf: MJDPRole).
	self assert: (role associatedClass isMemberOf: FMMultivalueLink).
	self assert: role associatedClass isEmpty.
	
	role associatedClass: classRoleAssoc.
	
	self assert: (role associatedClass isMemberOf: FMMultivalueLink).
	self assert: role associatedClass size equals: 1.	
	self assert: role associatedClass first equals: classRoleAssoc.
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> testMJDPRoleCreation [
	| role |

	role := MJDPRole new.
	
	self assert: (role isMemberOf: MJDPRole).
	self assert: (role associatedClass isMemberOf: FMMultivalueLink).
	self assert: role associatedClass isEmpty.
]
