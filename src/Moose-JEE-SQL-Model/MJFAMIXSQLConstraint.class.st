Class {
	#name : #MJFAMIXSQLConstraint,
	#superclass : #MooseEntity,
	#instVars : [
		'name',
		'isPKConstraint',
		'isFKConstraint',
		'fkReferencedTableName',
		'fkColumns',
		'pkColumns',
		'isUnique',
		'uniqueColumns',
		'isCheckConstraint',
		'expressionString'
	],
	#category : #'Moose-JEE-SQL-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXSQLConstraint class >> annotation [
	<MSEClass: #MJFAMIXSQLConstraint super: #MooseEntity>
	<package: #'Moose-JEE-Model'>
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> addFKColumnName: aString [
	fkColumns addLast: aString.
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> addPKColumnName: aString [
	pkColumns addLast: aString.
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> addUniqueColumnName: aString [
	uniqueColumns addLast: aString.
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> expressionString [
	^ expressionString
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> expressionString: aString [
	expressionString := aString
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> fkColumnNames [
	^fkColumns
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> initialize [
	super initialize.	
	name := nil.
	isPKConstraint := nil.
	isFKConstraint := nil.
	fkColumns := OrderedCollection new.
	pkColumns := OrderedCollection new.
	uniqueColumns := OrderedCollection new.
	fkReferencedTableName := nil.
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> isCheck [
	<property: #isCheck>
	^ isCheckConstraint
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> isCheck: aBoolean [
	isCheckConstraint := aBoolean
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isFKConstraint [
	<property: #isFKConstraint>
	^isFKConstraint
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isFKConstraint: aBoolean [
	isFKConstraint := aBoolean
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isPKConstraint [
	<property: #isPKConstraint>
	^isPKConstraint
	
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> isPKConstraint: aBoolean [
	isPKConstraint := aBoolean
	
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> isUnique [
	<property: #isUnique>
	^ isUnique
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> name [
	^ name
]

{ #category : #accessing }
MJFAMIXSQLConstraint >> name: aString [
	name := aString
]

{ #category : #initialization }
MJFAMIXSQLConstraint >> pkColumnNames [
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

{ #category : #initialization }
MJFAMIXSQLConstraint >> uniqueColumnNames [
	^uniqueColumns
]
