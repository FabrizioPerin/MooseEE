Class {
	#name : #FAMIXLayer,
	#superclass : #FAMIXEntity,
	#instVars : [
		'containedClasses'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXLayer class >> annotation [
	<MSEClass: #Layer super: #FAMIXEntity>
	<package: 'FAMIX'>
	^self
]

{ #category : #accessing }
FAMIXLayer >> containedClasses [
	^containedClasses
]

{ #category : #initialization }
FAMIXLayer >> initialize [ 
	super initialize.
	containedClasses := OrderedCollection new.
	^self
]

{ #category : #'as yet unclassified' }
FAMIXLayer >> populate: aMooseModel [

	| layer |

	layer := self selectClassesFrom: aMooseModel.
	aMooseModel add: layer.
	
]

{ #category : #'as yet unclassified' }
FAMIXLayer >> selectClassesFrom: aMooseModel [
	^self subclassResponsibility
]
