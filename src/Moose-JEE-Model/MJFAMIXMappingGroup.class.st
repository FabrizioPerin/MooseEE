Class {
	#name : #MJFAMIXMappingGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXMappingGroup class >> annotation [

	<MSEClass: #MJFAMIXMappingGroup super: #MJAbstractGroup>
	<package: #'Moose-JEE-Model'>
]

{ #category : #'as yet unclassified' }
MJFAMIXMappingGroup >> saveListOfMapsOnFile [
	| stream fileName |
	
	fileName := UIManager default request: 'Insert a file name'.
	
	(fileName isNil or: [fileName = '']) 
		ifTrue: [ DialogWindow new alert: 'Invalid file name']
		ifFalse: [
			stream := CrLfFileStream forceNewFileNamed: fileName.
			self do: [:map |
				stream nextPutAll: (map from mooseName asString , Character space asString , map to name asString , String cr asString)].	
			stream close.
			
			^stream].
]
