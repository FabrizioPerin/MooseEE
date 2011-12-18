Class {
	#name : #MJDPRoleAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'role',
		'implementor'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'fame annotation' }
MJDPRoleAssociation class >> annotation [
	<MSEClass: #MJDPRoleAssociation super: #FAMIXAssociation>
	<package: #'Moose-JEE-DesignPattern'>
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> from [
	^ self role
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> implementor [
	<MSEProperty: #implementor type: #FAMIXType opposite: #dpRole>
	<MSEComment: 'FamixType participating the pattern'>
	
	^implementor
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> implementor: aFamixType [

	implementor := FMMultivalueLink 
					on: self
					update: #role:
					from: self class  
					to: aFamixType
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> initialize [

	super initialize.
	
	role := nil.
	implementor := nil.
	
	^self
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (DPRoleAssociation)'
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> role [
	<MSEProperty: #role type: #MJDPRole opposite: #associatedClass>
	<MSEComment: 'Design Pattern role'>
	
	^role
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> role: aMJDPRole [

	role := FMMultivalueLink 
					on: self
					update: #associatedClass:
					from: self class  
					to: aMJDPRole
]

{ #category : #'as yet unclassified' }
MJDPRoleAssociation >> to [
	^ self implementor
]
