Class {
	#name : #MJDPRoleTests,
	#superclass : #TestCase,
	#instVars : [
		'associatedClass'
	],
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'as yet unclassified' }
MJDPRoleTests class >> annotation [
	<MSEClass: #MJDPRole super: #FAMIXEntity>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> initialize [
	super initialize.
	
	associatedClass := FMMultivalueLink on: self opposite: #role:.
	
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> testAnnotation [
	self assert: MJDPRole annotation == MJDPRole.
]

{ #category : #'as yet unclassified' }
MJDPRoleTests >> testMJDPRoleCreation [
	| role |

	role := MJDPRole new.
	
	self assert: (role isMemberOf: MJDPRole).
	self assert: (role associatedClass isMemberOf: FMMultivalueLink).
	self assert: role associatedClass isEmpty.
	
]
