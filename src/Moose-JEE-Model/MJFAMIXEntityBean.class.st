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
	<MSEClass: #EntityBean super: #MJFAMIXEJBean>
	<package: #'Moose-JEE-Model'>
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

{ #category : #accessing }
MJFAMIXEntityBean >> viewUMLOfImplementors [
	<menuItem: 'UML class diagram of the implementor' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLOfImplementorsOn: view.
	view open.
]

{ #category : #accessing }
MJFAMIXEntityBean >> viewUMLOfImplementorsOn: view [
	
	view shape umlClassWithAll.
	view interaction menu: #mooseMenuMorph.
	view node: self implementationClass.
]
