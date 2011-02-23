Class {
	#name : #MJFAMIXMappingGroup,
	#superclass : #MJAbstractGroup,
	#category : #'Moose-JEE-Model'
}

{ #category : #'as yet unclassified' }
MJFAMIXMappingGroup >> printOutListOfMaps [
	| stream |
	
	stream := CrLfFileStream forceNewFileNamed: 'maps.txt'.
	
	self do: [:map |
		stream nextPutAll: (map from mooseName asString , Character space asString , map to name asString , String cr asString)].	
	stream close.
	
	^stream
]
