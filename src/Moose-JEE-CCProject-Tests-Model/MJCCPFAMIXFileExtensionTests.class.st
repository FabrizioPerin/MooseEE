Class {
	#name : #MJCCPFAMIXFileExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #'as yet unclassified' }
MJCCPFAMIXFileExtensionTests >> testAddCloneSource [
	| file cloneSource |
	
	file := FAMIXFile new name: 'test'.
	cloneSource := MJCCPSource new.
	
	file addCloneSource: cloneSource.
	
	self assert: (file cloneSources isMemberOf: FMMultivalueLink).
	self assert: file cloneSources size equals: 1.
	self assert: file cloneSources first equals: cloneSource.	
	
]

{ #category : #'as yet unclassified' }
MJCCPFAMIXFileExtensionTests >> testCleanAllCloneSources [
	| file cloneSource |
	
	file := FAMIXFile new name: 'test'.
	cloneSource := MJCCPSource new.
	
	self assert: (file cloneSources isMemberOf: FMMultivalueLink). 
	self assert: file cloneSources size equals: 0.
	
	file addCloneSource: cloneSource.
	
	self assert: (file cloneSources isMemberOf: FMMultivalueLink).
	self assert: file cloneSources size equals: 1.
	self assert: file cloneSources first equals: cloneSource.
	
	file cleanAllCloneSources.
	
	self assert: (file cloneSources isMemberOf: FMMultivalueLink). 
	self assert: file cloneSources size equals: 0.
	
]

{ #category : #'as yet unclassified' }
MJCCPFAMIXFileExtensionTests >> testCloneSources [
	| file cloneSource |

	file := FAMIXFile new name: 'test'.
	
	self assert: (file cloneSources isMemberOf: FMMultivalueLink).
	self assert: file cloneSources size equals: 0.

]
