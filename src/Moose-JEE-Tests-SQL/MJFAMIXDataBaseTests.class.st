Class {
	#name : #MJFAMIXDataBaseTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests-SQL'
}

{ #category : #tests }
MJFAMIXDataBaseTests >> testAnnotation [
	self assert: FAMIXDataBase annotation == FAMIXDataBase.
]

{ #category : #'as yet unclassified' }
MJFAMIXDataBaseTests >> testPrintOn [
	| db stream |

	db := FAMIXDataBase new name: 'Database1'.
	
	stream := ReadWriteStream on: ''.
	db printOn: stream.
	
	self assert: (stream contents = (db name asString , ' (Database)')).
]

{ #category : #'as yet unclassified' }
MJFAMIXDataBaseTests >> testTables [
	| db stream |

	db := FAMIXDataBase new name: 'Database1'.
	
	self assert: (db tables isMemberOf: OrderedCollection).
	
	db tables: (OrderedCollection with: (FAMIXTable new name: 'table1') with: (FAMIXTable new name: 'table2')).
	
	self assert: (db tables isMemberOf: OrderedCollection).
	self assert: (db tables size = 2).
	self assert: (db tables first isMemberOf: FAMIXTable).
	self assert: (db tables first name = 'table1').
	

]
