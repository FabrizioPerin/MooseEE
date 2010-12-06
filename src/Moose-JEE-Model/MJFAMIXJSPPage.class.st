Class {
	#name : #MJFAMIXJSPPage,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'filedIn',
		'outgoingJspInvocations'
	],
	#category : #'Moose-JEE-Model'
}

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

{ #category : #accessing }
MJFAMIXJSPPage >> outgoingJspInvocations: aMapping [
	outgoingJspInvocations value: aMapping.
]
