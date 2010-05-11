Class {
	#name : #MJFAMIXLayer,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedClasses'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXLayer class >> annotation [
	<MSEClass: #Layer super: #FAMIXEntity>
	<package: 'FAMIX'>
	^self
]

{ #category : #accessing }
MJFAMIXLayer >> containedClasses [
	^containedClasses
]

{ #category : #initialization }
MJFAMIXLayer >> initialize [ 
	super initialize.
	containedClasses := OrderedCollection new.
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
