Class {
	#name : #FAMIXMapping,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetRelationalEntity',
		'sourceNamedEntity',
		'maps',
		'mapped'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXMapping class >> annotation [
	<MSEClass: #DBMapping super: 'FAMIX.Association'>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXMapping class >> source: aNamedEntity target: aRelationalEntity [

	^self new sourceNamedEntity: aNamedEntity; targetRelationalEntity: aRelationalEntity.

]

{ #category : #'as yet unclassified' }
FAMIXMapping >> from [

	^ self sourceNamedEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> initialize [
	super initialize.
	maps := nil.
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapped [
	<MSEProperty: #mapped type: #FAMIXRelationalEntity opposite: #definedBy>
	<MSEComment: 'Relational element mapped into the system by a Named Entity.'>
	
	^mapped
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapped: aRelationalEntity [

	mapped := FMMultivalueLink 
								on: self
								update: #definedBy
								from: self mapped
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> maps [

	<MSEProperty: #maps type: #FAMIXNamedEntity opposite: #defines>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^maps
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> maps: aNamedEntity [
	
	maps := FMMultivalueLink 
								on: self
								update: #defines
								from: self maps
								to: aNamedEntity
	
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> sourceNamedEntity [

	<MSEProperty: #sourceNamedEntity type: #FAMIXRelationalEntity opposite: #definedBy>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^sourceNamedEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> sourceNamedEntity: aNamedEntity [

	sourceNamedEntity := FMMultivalueLink 
										on: self
										update: #definedBy
										from: self sourceNamedEntity
										to: aNamedEntity

]

{ #category : #'as yet unclassified' }
FAMIXMapping >> targetRelationalEntity [

	<MSEProperty: #targetRelationalEntity type: #FAMIXNamedEntity opposite: #defines>
	<MSEComment: 'Relational element mapped into the system by a Named Entity.'>
	
	^targetRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> targetRelationalEntity: aRelationalEntity [

	targetRelationalEntity := FMMultivalueLink 
										on: self
										update: #defines
										from: self targetRelationalEntity
										to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> to [

	^ self targetRelationalEntity
]
