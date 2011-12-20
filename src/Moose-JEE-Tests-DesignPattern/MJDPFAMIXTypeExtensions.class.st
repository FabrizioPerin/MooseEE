Class {
	#name : #MJDPFAMIXTypeExtensions,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPFAMIXTypeExtensions >> testImplementedRole [
	| class |
	
	class := FAMIXType new.
	
	self assert: (class implementedRole isMemberOf: FMMultivalueLink).
	self assert: class implementedRole isEmpty.
]

{ #category : #'as yet unclassified' }
MJDPFAMIXTypeExtensions >> testSetImplementedRole [
	| class roleAssoc |
	
	class := FAMIXType new.
	roleAssoc := MJDPRoleAssociation new.
	
	self assert: (class implementedRole isMemberOf: FMMultivalueLink).
	self assert: class implementedRole isEmpty.
	
	class implementedRole: roleAssoc.
	
	self assert: class implementedRole size equals: 1.
	self assert: class implementedRole first equals: roleAssoc.
]
