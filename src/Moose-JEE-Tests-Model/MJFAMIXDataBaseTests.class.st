Class {
	#name : #MJFAMIXDataBaseTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests-Model'
}

{ #category : #tests }
MJFAMIXDataBaseTests >> testAnnotation [
	self assert: MJFAMIXDataBase annotation == MJFAMIXDataBase.
]

{ #category : #'as yet unclassified' }
MJFAMIXDataBaseTests >> testPrintOn [
	| db stream |

	db := MJFAMIXDataBase new name: 'Database1'.
	
	stream := ReadWriteStream on: ''.
	db printOn: stream.
	
	self assert: (stream contents = (db name asString , ' (Database)')).
]

{ #category : #'as yet unclassified' }
MJFAMIXDataBaseTests >> testTables [
	| db stream |

	db := MJFAMIXDataBase new name: 'Database1'.
	
	self assert: (db tables isMemberOf: OrderedCollection).
	
	db tables: (OrderedCollection with: (MJFAMIXTable new name: 'table1') with: (MJFAMIXTable new name: 'table2')).
	
	self assert: (db tables isMemberOf: OrderedCollection).
	self assert: (db tables size = 2).
	self assert: (db tables first isMemberOf: MJFAMIXTable).
	self assert: (db tables first name = 'table1').
	

]
