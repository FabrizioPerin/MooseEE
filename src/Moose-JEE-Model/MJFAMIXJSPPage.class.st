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
	
	outgoingJspInvocations := FMMultivalueLink on: self opposite: #mapTarget:.
	

	^self
]

{ #category : #accessing }
MJFAMIXJSPPage >> outgoingJspInvocations [

	<MSEProperty: #mappedBy type: #MJFAMIXJSPInvocation opposite: #mapTarget> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^outgoingJspInvocations
]

{ #category : #accessing }
MJFAMIXJSPPage >> outgoingJspInvocations: aMapping [
	outgoingJspInvocations value: aMapping.
]
