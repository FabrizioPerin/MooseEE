Class {
	#name : #MJFAMIXLayer,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedClasses'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLayer class >> annotation [
	<MSEClass: #MJFAMIXLayer super: #FAMIXEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> acceptStrategy: aLayeringStrategy [
	^self subclassResponsibility
]

{ #category : #accessing }
MJFAMIXLayer >> belongsTo [ 
	^''
]

{ #category : #accessing }
MJFAMIXLayer >> containedClasses [
	^containedClasses
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> fileOutContainedClasses [
	<menuItem: 'File out contained classes list' category: 'JEAs Utilities'>
	| stream name |
	
	name := self name.
	name := name removeSuffix: ' Layer'.
	
	stream := MultiByteFileStream forceNewFileNamed: (name , '.out').
	
	self containedClasses do: [:class |
		stream nextPutAll: (class mooseName asString , String cr asString)].
	stream close.
]

{ #category : #initialization }
MJFAMIXLayer >> initialize [ 
	super initialize.
	containedClasses := Set new.
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> populate: aMooseModel [

	| layer |

	layer := self selectClassesFrom: aMooseModel.
	aMooseModel add: layer.
	
]

{ #category : #'as yet unclassified' }
MJFAMIXLayer >> selectClassesFrom: aMooseModel [
	^self subclassResponsibility
]
