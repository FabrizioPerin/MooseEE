Class {
	#name : #MJFAMIXFKAssociationGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #meta }
MJFAMIXFKAssociationGroup class >> annotation [

	<MSEClass: #MJFAMIXFKAssociationGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>

]

{ #category : #'as yet unclassified' }
MJFAMIXFKAssociationGroup >> exportListOfFKsAsCSVFile [
	| stream fileName |
	
	fileName := UIManager default request: 'Insert a file name ( .csv extension will be automatically added )'.
	
	(fileName isNil or: [fileName = '']) 
		ifTrue: [ DialogWindow new alert: 'Invalid file name']
		ifFalse: [
			stream := CrLfFileStream forceNewFileNamed: fileName , '.csv'.
			stream nextPutAll: ('REFERENCED TABLE' , ';' , 'REFERENCED TABLE COLUMN' , ';' , 'REFERENCING TABLE' , ';' , 'REFERENCING TABLE COLUMN' , String cr).
			self do: [:fkAssoc |
				stream nextPutAll: (fkAssoc targetColumn ownerTable name , ';' , fkAssoc targetColumn name , ';' , fkAssoc sourceColumn ownerTable name , ';' , fkAssoc sourceColumn name , String cr)].	
			stream close.
			
			^stream].
]
