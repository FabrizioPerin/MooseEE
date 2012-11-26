Class {
	#name : #MEEContainment,
	#superclass : #MEEArchitecturalAssociation,
	#instVars : [
		'containerComponent',
		'containedElement'
	],
	#category : #'Moose-JEE-Architecture'
}

{ #category : #'fame annotation' }
MEEContainment class >> annotation [
	<MSEClass: #MEEContainment super: #MJAssociation>
	<package: #'Babel-Model'>
	^self
]

{ #category : #accessing }
MEEContainment >> containedElement [
	
	<MSEProperty: #containedElement type: #FAMIXType opposite: #containerComponents>
	<MSEComment: 'Type contained in the component.'>
	
	^containedElement
]

{ #category : #accessing }
MEEContainment >> containedElement: aFamixType [
	

	containedElement := FMMultivalueLink 
								on: self
								update: #containerComponents
								from: self containedElement  
								to: aFamixType
]

{ #category : #accessing }
MEEContainment >> containerComponent [
	<MSEProperty: #containerComponent type: #MEEArchitecturalComponent opposite: #containedElements>
	<MSEComment: 'Component which contains the source entities.'>
	
	^containerComponent
]

{ #category : #accessing }
MEEContainment >> containerComponent: aBAComponent [

	containerComponent := FMMultivalueLink 
								on: self
								update: #containedElements
								from: self containerComponent  
								to: aBAComponent
]

{ #category : #accessing }
MEEContainment >> from [
	^ self containerComponent
]

{ #category : #initialization }
MEEContainment >> initialize [
	super initialize.
	
	containerComponent := nil.
	containedElement := nil.
]

{ #category : #printing }
MEEContainment >> mooseNameOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (BAContainment)'
]

{ #category : #printing }
MEEContainment >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to mooseName].
	aStream nextPutAll: ' (BAContainment)'
]

{ #category : #accessing }
MEEContainment >> to [
	^ self containedElement
]
