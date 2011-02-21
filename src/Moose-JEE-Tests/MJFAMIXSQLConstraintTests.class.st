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
	
	self assert: (const fkColumnsName size = 2). 
	self assert: (const fkColumnsName first = #Col1).
	self assert: (const fkColumnsName second = #Col2).  
]

{ #category : #initialization }
MJFAMIXSQLConstraintTests >> testAddPKColumnName [
	| const |

	const := MJFAMIXSQLConstraint new.

	const addPKColumnName: #Col1.
	const addPKColumnName: #Col2.
	
	self assert: (const pkColumnsName size = 2). 
	self assert: (const pkColumnsName first = #Col1).
	self assert: (const pkColumnsName second = #Col2).  
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