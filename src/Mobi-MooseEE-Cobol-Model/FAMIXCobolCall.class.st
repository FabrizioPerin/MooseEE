"
A FAMIXCobolCall is either an actual call between two cobol modules, or it is a cobol include statement.

Instance Variables
	source:		the invoker or the module containing the include statement
	target:		the receiver of the call or the imported module

"
Class {
	#name : #FAMIXCobolCall,
	#superclass : #MJAssociation,
	#instVars : [
		'target',
		'source'
	],
	#category : #'Mobi-MooseEE-Cobol-Model'
}

{ #category : #'as yet unclassified' }
FAMIXCobolCall class >> annotation [
	<MSEClass: #CobolCall super: #MJFAMIXDerivedDependency>
	<package: #FAMIX>
	
	^self
]

{ #category : #'as yet unclassified' }
FAMIXCobolCall >> from [

	^ self source
]

{ #category : #'as yet unclassified' }
FAMIXCobolCall >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (Cobol Call)'
]

{ #category : #'as yet unclassified' }
FAMIXCobolCall >> source [
	<MSEProperty: #source type: #FAMIXCobolList opposite: #outgoingCalls:>
	<MSEComment: 'Cobol list generating this call. from-side of the association'>
	
	^source
]

{ #category : #'as yet unclassified' }
FAMIXCobolCall >> source: aCobolList [
	source := FMMultivalueLink on: self
					update: #outgoingCalls
					from: self source
					to: aCobolList
]

{ #category : #accessing }
FAMIXCobolCall >> target [
	<MSEProperty: #target type: #FAMIXCobolList opposite: #incomingCalls:>
	<MSEComment: 'Cobol list receiving this call. to-side of the association'>
	
	^target
]

{ #category : #accessing }
FAMIXCobolCall >> target: aCobolList [
	target := FMMultivalueLink on: self
					update: #incomingCalls
					from: self target
					to: aCobolList
]

{ #category : #'as yet unclassified' }
FAMIXCobolCall >> to [

	^ self target
]
