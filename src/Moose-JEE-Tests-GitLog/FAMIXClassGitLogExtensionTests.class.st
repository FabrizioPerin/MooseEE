Class {
	#name : #FAMIXClassGitLogExtensionTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests-GitLog'
}

{ #category : #'as yet unclassified' }
FAMIXClassGitLogExtensionTests >> testAddAssociatedBlame [
	| assoc class |

	assoc := MJBlameClassAssociation new.
	class := FAMIXClass new.
	
	class associatedBlameFile add: assoc.
	
	self assert: (class associatedBlameFile isMemberOf: FMMultivalueLink).
	self assert: (class associatedBlameFile size = 1).
	self assert: (class associatedBlameFile first = assoc).

]

{ #category : #'as yet unclassified' }
FAMIXClassGitLogExtensionTests >> testAssociatedBlame [
	| class |

	class := FAMIXClass new.
	
	self assert: (class associatedBlameFile isMemberOf: FMMultivalueLink).
	self assert: (class dbAccesses size = 0).
]

{ #category : #'as yet unclassified' }
FAMIXClassGitLogExtensionTests >> testDevelpers [

	| bf bl1 bl2 john famixAnchor class mm |
	
	bf := MJBlameFile new fileName: 'unknown.java'.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.

	john := MJAuthor named: 'John'.
	bl1 := MJBlameFileLine new author: john.
	bl2 := MJBlameFileLine new author: john.
	
	bf addLine: bl1.
	bf addLine: bl2.

	famixAnchor := FAMIXFileAnchor new fileName: 'unknown.java'.
	class := FAMIXClass new sourceAnchor: famixAnchor.
	
	mm := MooseModel new.
	mm withoutAnnounceAdd: class.
	mm withoutAnnounceAdd: famixAnchor.
	mm withoutAnnounceAdd: bf.
	mm withoutAnnounceAdd: john.
	
	self assert: (class developers isMemberOf: Dictionary).
	self assert: class developers keys size equals: 1.
	self assert: class developers keys first equals: john.
	
	

]

{ #category : #'as yet unclassified' }
FAMIXClassGitLogExtensionTests >> testExpert [

	| bf bl1 bl2 john famixAnchor class assoc |
	
	bf := MJBlameFile new fileName: 'unknown.java'.
	
	self assert: (bf lines isMemberOf: OrderedCollection).
	self assert: bf lines isEmpty.

	john := MJAuthor named: 'John'.
	bl1 := MJBlameFileLine new author: john.
	bl2 := MJBlameFileLine new author: john.
	
	bf addLine: bl1.
	bf addLine: bl2.

	famixAnchor := FAMIXFileAnchor new fileName: 'unknown.java'.
	class := FAMIXClass new sourceAnchor: famixAnchor.
	
	assoc := MJBlameClassAssociation new.
	assoc target: class.
	assoc source: bf.
	
	class addAssociatedBlame: assoc.
	bf addAssociatedClass: assoc.
	
	self assert: class expert equals: john.

]
