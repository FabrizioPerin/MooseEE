Class {
	#name : #MJFAMIXSQLConstraint,
	#superclass : #Object,
	#instVars : [
		'name',
		'isPKConstraint',
		'isFKConstraint',
		'fkReferencedTableName',
		'fkColumns',
		'pkColumns'
	],
	#category : #'Moose-JEE-Model'
}

{ #category : #initialization }
MJFAMIXSQLConstraint >> addFKColumnName: aString [
	fkColumns addLast: aString.
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> addPKColumnName: aString [
	pkColumns addLast: aString.
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> fkColumnsName [
	^fkColumns
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> initialize [
	name := nil.
	isPKConstraint := nil.
	isFKConstraint := nil.
	fkColumns := OrderedCollection new.
	pkColumns := OrderedCollection new.
	fkReferencedTableName := nil.
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isFKConstraint [
	^isFKConstraint
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isFKConstraint: aBoolean [
	isFKConstraint := aBoolean
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isPKConstraint [
	^isPKConstraint
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isPKConstraint: aBoolean [
	isPKConstraint := aBoolean
	
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> name [

	^name
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> name: aString [

	name := aString.
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> pkColumnsName [
	^pkColumns
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> referencedTableName [
	^fkReferencedTableName
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> referencedTableName: aString [
	fkReferencedTableName := aString.
]
