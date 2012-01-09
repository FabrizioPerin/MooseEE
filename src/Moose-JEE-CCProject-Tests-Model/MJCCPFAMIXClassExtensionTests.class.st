Class {
	#name : #MJCCPFAMIXClassExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-CCProject-Tests-Model'
}

{ #category : #'as yet unclassified' }
MJCCPFAMIXClassExtensionTests >> testAddClone [
	| class cloneSource |
	
	class := FAMIXClass new name: 'test'.
	cloneSource := MJCCPSource new.
	
	class addClone: cloneSource.
	
	self assert: (class clones isMemberOf: FMMultivalueLink).
	self assert: class clones size equals: 1.
	self assert: class clones first equals: cloneSource.	
	
]

{ #category : #'as yet unclassified' }
MJCCPFAMIXClassExtensionTests >> testCleanAllCloneSources [
	| class cloneSource |
	
	class := FAMIXClass new name: 'test'.
	cloneSource := MJCCPSource new.
	
	self assert: (class clones isMemberOf: FMMultivalueLink). 
	self assert: class clones size equals: 0.
	
	class addClone: cloneSource.
	
	self assert: (class clones isMemberOf: FMMultivalueLink).
	self assert: class clones size equals: 1.
	self assert: class clones first equals: cloneSource.
	
	class cleanAllCloneSources.
	
	self assert: (class clones isMemberOf: FMMultivalueLink). 
	self assert: class clones size equals: 0.
	
]

{ #category : #'as yet unclassified' }
MJCCPFAMIXClassExtensionTests >> testClones [
	| class cloneSource |

	class := FAMIXClass new name: 'test'.
	
	self assert: (class clones isMemberOf: FMMultivalueLink).
	self assert: class clones size equals: 0.

]
