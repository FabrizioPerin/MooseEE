Class {
	#name : #FAMIXEntityBean,
	#superclass : #FAMIXEJBean,
	#instVars : [
		'persistenceType',
		'primaryKeyClass'
	],
	#category : #'Moose-JEE'
}

{ #category : #accessing }
FAMIXEntityBean >> isBMP [

	^self persistenceType = #Bean
]

{ #category : #accessing }
FAMIXEntityBean >> isCMP [

	^self persistenceType = #Container
]

{ #category : #accessing }
FAMIXEntityBean >> persistenceType [
	^persistenceType
]

{ #category : #accessing }
FAMIXEntityBean >> persistenceType: anObject [
	persistenceType := anObject asSymbol
]

{ #category : #accessing }
FAMIXEntityBean >> primaryKeyClass [
	^primaryKeyClass
]

{ #category : #accessing }
FAMIXEntityBean >> primaryKeyClass: anObject [
	primaryKeyClass := anObject
]
