Class {
	#name : #FAMIXDBMapping,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'behaviouralEntity',
		'relationalEntity'
	],
	#category : #'Moose-JEE'
}

{ #category : #'as yet unclassified' }
FAMIXDBMapping class >> annotation [
	<MSEClass: #DBMapping super: 'FAMIX.Association'>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> behaviouralEntity [

	<MSEProperty: #behaviouralEntity type: #FAMIXBehaviouralEntity opposite: #defined>
	<MSEComment: 'Behavioural Entity maps a Relational elements.'>
	
	^behaviouralEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> behaviouralEntity: aBehaviouralEntity [

	behaviouralEntity := FMMultivalueLink on: self
											update: #defined
											from: self behaviouralEntity
											to: aBehaviouralEntity

]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> from [

	^ self behaviouralEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> initialize [
	super initialize.
	behaviouralEntity := nil.
	relationalEntity := nil.
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> relationalEntity [

	<MSEProperty: #relationalEntity type: #FAMIXBehaviouralEntity opposite: #defines>
	<MSEComment: 'Relational element mapped into the system by a Behavioural Entity.'>
	
	^relationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> relationalEntity: aRelationalElement [

	relationalEntity := FMMultivalueLink on: self
										update: #defines
										from: self relationalEntity
										to: aRelationalElement
]

{ #category : #'as yet unclassified' }
FAMIXDBMapping >> to [

	^ self relationalEntity
]
