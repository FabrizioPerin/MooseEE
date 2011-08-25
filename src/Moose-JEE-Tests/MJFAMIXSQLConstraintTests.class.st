Class {
	#name : #MJFAMIXSQLConstraintTests,
	#superclass : #TestCase,
	#category : #'Moose-JEE-Tests'
}

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testAddFKColumnName [
	| const |

	const := MJFAMIXSQLConstraint new.

	const addFKColumnName: #Col1.
	const addFKColumnName: #Col2.
	
	self assert: (const fkColumnNames size = 2). 
	self assert: (const fkColumnNames first = #Col1).
	self assert: (const fkColumnNames second = #Col2).  
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testAddPKColumnName [
	| const |

	const := MJFAMIXSQLConstraint new.

	const addPKColumnName: #Col1.
	const addPKColumnName: #Col2.
	
	self assert: (const pkColumnNames size = 2). 
	self assert: (const pkColumnNames first = #Col1).
	self assert: (const pkColumnNames second = #Col2).  
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testAddUniqueColumnName [
	| const |

	const := MJFAMIXSQLConstraint new.

	const addUniqueColumnName: 'uniqueColumn'.
	
	self assert: (const uniqueColumnNames size = 1).
	self assert: (const uniqueColumnNames first = 'uniqueColumn').
]

{ #category : #tests }
MJFAMIXSQLConstraintTests >> testAnnotation [
	self assert: MJFAMIXSQLConstraint annotation == MJFAMIXSQLConstraint.
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testIsCheck [
	| const |

	const := MJFAMIXSQLConstraint new.
	
	const isCheck: true.
	
	self assert: (const expressionString = nil).
	
	const expressionString: 'should be an expression'.
	
	self assert: (const expressionString = 'should be an expression').
	
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testIsFKConstraint [	
	| const |

	const := MJFAMIXSQLConstraint new.

	self assert: (const isFKConstraint = nil).
	
	const isFKConstraint: true.
	
	self assert: const isFKConstraint.
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testIsPKConstraint [	
	| const |

	const := MJFAMIXSQLConstraint new.

	self assert: (const isPKConstraint = nil).
	
	const isPKConstraint: true.
	
	self assert: const isPKConstraint.
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testIsUnique [
	| const |

	const := MJFAMIXSQLConstraint new.

	self assert: (const isUnique = nil).
	
	const isUnique: true.
	
	self assert: const isUnique.
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testName [
	| const |

	const := MJFAMIXSQLConstraint new.
	
	self assert: (const name = nil).
	
	const := MJFAMIXSQLConstraint new name: 'Constraint_1'.
	
	self assert: (const name = 'Constraint_1').
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testReferencedTableName [
	| const |

	const := MJFAMIXSQLConstraint new.
	
	self assert: (const referencedTableName = nil).
	
	const referencedTableName: 'Tab1'.  
	
	self assert: (const referencedTableName = #Tab1). 

]
