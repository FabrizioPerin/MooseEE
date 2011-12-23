Class {
	#name : #MJFAMIXJSPPage,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'filedIn',
		'outgoingJspInvocations'
	],
	#category : #'Moose-JEE-JSP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXJSPPage class >> annotation [
	<MSEClass: #MJFAMIXJSPPage super: #FAMIXNamedEntity>
	<package: #'Moose-JEE-JSP-Model'>
]

{ #category : #accessing }
MJFAMIXJSPPage >> addOutgoingJspInvocations: aMapping [
	outgoingJspInvocations add: aMapping.
]

{ #category : #accessing }
MJFAMIXJSPPage >> filedIn [
	^ filedIn
]

{ #category : #accessing }
MJFAMIXJSPPage >> filedIn: aFilePath [
	filedIn := aFilePath asString
]

{ #category : #accessing }
MJFAMIXJSPPage >> initialize [
	super initialize.
	outgoingJspInvocations := FMMultivalueLink on: self opposite: #invocationSource:.
]

{ #category : #accessing }
MJFAMIXJSPPage >> outgoingJspInvocations [

	<MSEProperty: #outgoingJspInvocations type: #MJFAMIXJSPInvocation opposite: #invocationSource> <multivalued> <derived>
	<MSEComment: 'invocation relationships.'>
	
	^outgoingJspInvocations
]
