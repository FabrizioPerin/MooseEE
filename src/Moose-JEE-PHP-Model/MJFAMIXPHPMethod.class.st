Class {
	#name : #MJFAMIXPHPMethod,
	#superclass : #FAMIXMethod,
	#category : #'Moose-JEE-PHP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXPHPMethod class >> annotation [
	<MSEClass: #MJFAMIXPHPMethod super: #FAMIXMethod>
	<package: #'Moose-JEE-PHP-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPMethod >> isReference [
	self modifiers includes: #reference.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPMethod >> isReference: aBoolean [
	self modifierSet: aBoolean for: #reference.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPMethod >> isStatic [
	self modifiers includes: #static.
]

{ #category : #'as yet unclassified' }
MJFAMIXPHPMethod >> isStatic: aBoolean [
	self modifierSet: aBoolean for: #static. 
]
