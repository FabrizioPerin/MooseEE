Class {
	#name : #MJDPRoleAssociationTests,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'role',
		'implementor'
	],
	#category : #'Moose-JEE-Tests-DesignPattern'
}

{ #category : #'fame annotation' }
MJDPRoleAssociationTests class >> annotation [
	<MSEClass: #MJDPRoleAssociation super: #FAMIXAssociation>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> from [
	^ self role
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> implementor [
	<MSEProperty: #implementor type: #FAMIXType opposite: #dpRole>
	<MSEComment: 'FamixType participating the pattern'>
	
	^implementor
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> implementor: aFamixType [

	implementor := FMMultivalueLink 
					on: self
					update: #role:
					from: self class  
					to: aFamixType
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> initialize [

	super initialize.
	
	role := nil.
	implementor := nil.
	
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
MJDPRoleAssociationTests >> role [
	<MSEProperty: #role type: #MJDPRole opposite: #associatedClass>
	<MSEComment: 'Design Pattern role'>
	
	^role
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociationTests >> to [
	^ self implementor
]
