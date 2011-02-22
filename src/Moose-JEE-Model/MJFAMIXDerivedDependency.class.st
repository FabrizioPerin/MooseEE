"
MJFAMIXDerivedDependency describe a logical association among Named Entities that does not exist by itself in the code but it can be derived from another association. 

E.g. If a method invoke another method. Those two methods have an explicit association (in particular an invokation) that relates one another. Imagine that these two methods access two database's' tables. Formally there is anything that put these two tables in a relation but the link that there is between the methods. So in these case is possible to create a derived dependency between these tables.

Conceptually the MJFAMIXDerivedDependency does not have a direction although the implementation is between a source and a target of the relation.


Instance Variables:
	source	<FMMultivalueLink>
	target	<FMMultivalueLink>
"
Class {
	#name : #MJFAMIXDerivedDependency,
	#superclass : #MJAssociation,
	#instVars : [
		'source',
		'target'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency class >> annotation [
	<MSEClass: #MJFAMIXDerivedDependency super: #MJAssociation>
	<package: #'Moose-JEE-Model'>
	^self
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> from [

	^ self source
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> initialize [
	super initialize.
	
	source := nil.
	target := nil.
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> source [
	<MSEProperty: #source type: #FAMIXNamedEntity opposite: #outgoingDerivedDependency>
	<MSEComment: 'Source named entity of the derive dependency. from-side of the association'>
	
	^source
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> source: aNamedEntity [
	source := FMMultivalueLink on: self
					update: #outgoingDerivedDependency
					from: self source
					to: aNamedEntity
]

{ #category : #accessing }
MJFAMIXDerivedDependency >> target [
	<MSEProperty: #target type: #FAMIXNamedEntity opposite: #incomingDerivedDependency>
	<MSEComment: 'Target named entity of the derive dependency. to-side of the association'>
	
	^target
]

{ #category : #accessing }
MJFAMIXDerivedDependency >> target: aNamedEntity [
	target := FMMultivalueLink on: self
					update: #incomingDerivedDependency
					from: self target
					to: aNamedEntity
]

{ #category : #'as yet unclassified' }
MJFAMIXDerivedDependency >> to [

	^ self target
]
