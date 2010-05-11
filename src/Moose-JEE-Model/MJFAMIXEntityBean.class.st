Class {
	#name : #MJFAMIXEntityBean,
	#superclass : #MJFAMIXEJBean,
	#instVars : [
		'persistenceType',
		'primaryKeyClass'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXEntityBean class >> annotation [
	<MSEClass: 'EntityBean' super: #MJFAMIXEJBean>
	<package: 'FAMIX'>
]

{ #category : #testing }
MJFAMIXEntityBean >> isBMP [

	^self persistenceType = #Bean
]

{ #category : #testing }
MJFAMIXEntityBean >> isCMP [

	^self persistenceType = #Container
]

{ #category : #accessing }
MJFAMIXEntityBean >> persistenceType [
	^persistenceType
]

{ #category : #accessing }
MJFAMIXEntityBean >> persistenceType: anObject [
	persistenceType := anObject asSymbol
]

{ #category : #accessing }
MJFAMIXEntityBean >> primaryKeyClass [
	^primaryKeyClass
]

{ #category : #accessing }
MJFAMIXEntityBean >> primaryKeyClass: anObject [
	primaryKeyClass := anObject
]
