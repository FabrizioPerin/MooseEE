Class {
	#name : #MJFAMIXEntityBean,
	#superclass : #MJFAMIXEJBean,
	#instVars : [
		'persistenceType',
		'primaryKeyClass'
	],
	#category : #'Moose-JEE-Core-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXEntityBean class >> annotation [
	<MSEClass: #MJFAMIXEntityBean super: #MJFAMIXEJBean>
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
MJFAMIXEntityBean >> viewUMLOfImplementor [
	<menuItem: 'UML class diagram of the implementor' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewUMLOfImplementorOn: view.
	view open.
]

{ #category : #accessing }
MJFAMIXEntityBean >> viewUMLOfImplementorOn: view [
	
	view shape umlClassWithAll.
	view interaction menu: #mooseMenuMorph.
	view node: self implementationClass.
]
