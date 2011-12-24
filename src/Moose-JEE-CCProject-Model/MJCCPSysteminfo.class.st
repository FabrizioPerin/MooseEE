Class {
	#name : #MJCCPSysteminfo,
	#superclass : #FAMIXEntity,
	#instVars : [
		'granularity',
		'maxLines',
		'minLines',
		'system',
		'threshold'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPSysteminfo >> granularity [
	^ granularity
]

{ #category : #accessing }
MJCCPSysteminfo >> granularity: anObject [
	granularity := anObject
]

{ #category : #accessing }
MJCCPSysteminfo >> maxLines [
	^ maxLines
]

{ #category : #accessing }
MJCCPSysteminfo >> maxLines: anObject [
	maxLines := anObject
]

{ #category : #accessing }
MJCCPSysteminfo >> minLines [
	^ minLines
]

{ #category : #accessing }
MJCCPSysteminfo >> minLines: anObject [
	minLines := anObject
]

{ #category : #accessing }
MJCCPSysteminfo >> system [
	^ system
]

{ #category : #accessing }
MJCCPSysteminfo >> system: anObject [
	system := anObject
]

{ #category : #accessing }
MJCCPSysteminfo >> threshold [
	^ threshold
]

{ #category : #accessing }
MJCCPSysteminfo >> threshold: anObject [
	threshold := anObject
]
