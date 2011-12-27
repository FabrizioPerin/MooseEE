Class {
	#name : #MJCCPClones,
	#superclass : #FAMIXEntity,
	#instVars : [
		'systeminfo',
		'classinfo',
		'classes'
	],
	#category : #'Moose-JEE-CCProject-Model'
}

{ #category : #accessing }
MJCCPClones >> addClasses: aCloneClasses [
	classes addLast: aCloneClasses
]

{ #category : #accessing }
MJCCPClones >> classes [
	^ classes
]

{ #category : #accessing }
MJCCPClones >> classes: aCollectionOfCloneClasses [
	classes := aCollectionOfCloneClasses
]

{ #category : #accessing }
MJCCPClones >> classinfo [
	^ classinfo
]

{ #category : #accessing }
MJCCPClones >> classinfo: anObject [
	classinfo := anObject
]

{ #category : #accessing }
MJCCPClones >> systeminfo [
	^ systeminfo
]

{ #category : #accessing }
MJCCPClones >> systeminfo: anObject [
	systeminfo := anObject
]
