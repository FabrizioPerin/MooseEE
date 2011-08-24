Class {
	#name : #MJFAMIXDataBaseTests,
	#superclass : #MJFAMIXRelationalEntityTests,
	#category : #'Moose-JEE-Tests'
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
