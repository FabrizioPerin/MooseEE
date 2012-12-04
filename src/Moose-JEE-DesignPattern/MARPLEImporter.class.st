Class {
	#name : #MARPLEImporter,
	#superclass : #Object,
	#instVars : [
		'targetModel'
	],
	#category : #'Moose-JEE-DesignPattern'
}

{ #category : #'as yet unclassified' }
MARPLEImporter class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #'as yet unclassified' }
MARPLEImporter >> importPatternDefinitionFrom: aFile [
	| nl implementors |
	
	implementors := OrderedCollection new.
	
	aFile wantsLineEndConversion: true.
	aFile detectLineEndConvention.
	nl := aFile nextLine.
		
	[ nl == nil ] 
		whileFalse: [
			implementors add: nl.
			nl := aFile nextLine ].
	
	self populateTargetModelWith: implementors.
	
]

{ #category : #'as yet unclassified' }
MARPLEImporter >> populateTargetModelWith: implementors [
	"First entity name of the pattern. Other entities are the implementors. WARNING: possible duplicates"
	| role allClasses |
	
	role := MJDPRole new.
	role patternName: implementors removeFirst.
	allClasses := targetModel allClasses.
	targetModel silentlyAdd: role.
	
	implementors asSet do: [:each |
		| implementor |
		implementor := allClasses select: [:class | class mooseName asString = each ].
		implementor isEmpty ifFalse: [
			| assoc |
			assoc := MJDPRoleAssociation new.
			assoc role: role.
			assoc implementor: implementor first.
			targetModel silentlyAdd: assoc ] ]
]

{ #category : #'as yet unclassified' }
MARPLEImporter >> targetModel [
	^ targetModel
]

{ #category : #'as yet unclassified' }
MARPLEImporter >> targetModel: aModel [
	targetModel := aModel. 
]
