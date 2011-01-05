Class {
	#name : #MJFAMIXConstraint,
	#superclass : #FAMIXEntity,
	#instVars : [
		'name',
		'fkReferencedTableName',
		'fkColumns',
		'pkColumns'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXConstraint >> isFKConstraint [ 
	^false
]

{ #category : #'as yet unclassified' }
MJFAMIXConstraint >> isPKConstraint [ 
	^false
]
