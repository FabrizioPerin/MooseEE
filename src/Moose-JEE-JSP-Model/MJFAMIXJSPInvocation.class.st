Class {
	#name : #MJFAMIXJSPInvocation,
	#superclass : #MJAssociation,
	#instVars : [
		'invocationSource',
		'invocationTarget'
	],
	#category : #'Moose-JEE-JSP-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXJSPInvocation class >> annotation [
	<MSEClass: #MJFAMIXJSPInvocation super: #MJAssociation>
	<package: #'Moose-JEE-JSP-Model'>
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> from [

	^ self invocationSource
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> initialize [
	super initialize.
		
	invocationSource := nil.
	invocationTarget := nil.
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> invocationSource [

	<MSEProperty: #invocationSource type: #MJFAMIXJSPPage opposite: #outgoingJspInvocations>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^ invocationSource
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> invocationSource: anObject [
	invocationSource := FMMultivalueLink 
								on: self
								update: #outgoingJspInvocations
								from: self invocationSource
								to: anObject
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> invocationTarget [
	

	<MSEProperty: #invocationTarget type: #FAMIXClass opposite: #incomingJspInvocation>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^ invocationTarget
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> invocationTarget: anObject [
	invocationTarget := FMMultivalueLink 
								on: self
								update: #incomingJspInvocation
								from: self invocationTarget
								to: anObject
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (Invokes)'
]

{ #category : #accessing }
MJFAMIXJSPInvocation >> to [

	^ self invocationTarget
]
